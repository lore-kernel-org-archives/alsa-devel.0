From: Laurielle LEA <lauriellelea@yahoo.fr>
Subject: Sound with metal effect
Date: Thu, 31 Mar 2005 23:28:42 +0200 (CEST)
Message-ID: <20050331212842.26204.qmail@web25103.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-490394957-1112304522=:25995"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--0-490394957-1112304522=:25995
Content-Type: text/plain; charset=iso-8859-1
Content-Id: 
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I'm integrating ALSA to my voipclient (softphone) and
my problem is the sound received by the remote user is
with metal effect.
Do you know where it comes from ? From my readBuffer
function ? From my initDevice function ? ...

And where can I see the mail-archive because when I
went to=20
http://www.mail-archive.com/alsa-devel@lists.sourceforge.net/
there is no the current mail, the earlier date is in
June 2004.

Thanks in advance.

Regards,
Laurielle LEA.


=09

=09
	=09
__________________________________________________________________
D=E9couvrez le nouveau Yahoo! Mail : 250 Mo d'espace de stockage pour vos=
 mails !=20
Cr=E9ez votre Yahoo! Mail sur http://fr.mail.yahoo.com/
--0-490394957-1112304522=:25995
Content-Type: text/x-c++src; name="alsa.cpp"
Content-Description: alsa.cpp
Content-Disposition: inline; filename="alsa.cpp"


#define ALSA_DEVICE	"plughw:0,0"


AudioDriversALSA::AudioDriversALSA(DeviceMode mode) : AudioDrivers () {
	audio_hdl = (snd_pcm_t *) NULL;
	initDevice(mode);

}

AudioDriversALSA::~AudioDriversALSA (void) {
	/* Close the audio handle */
	if (audio_hdl != NULL) snd_pcm_close (audio_hdl);
}


int
AudioDriversALSA::initDevice (DeviceMode mode) {
	int	 err;
		
	if (devstate == DeviceOpened) {
		printf ("ERROR: ALSA Device Already Open !\n");
		return -1;
	}
	
	// Open the audio device
	// Flags : blocking (else have to OR omode with SND_PCM_NONBLOCK).
	switch (mode) {
	case ReadOnly:
		/* Only read sound from the device */
		err = snd_pcm_open (&audio_hdl, ALSA_DEVICE,SND_PCM_STREAM_CAPTURE, 
				SND_PCM_NONBLOCK);
		break;

	case WriteOnly:
		/* Only write sound to the device */
		err = snd_pcm_open (&audio_hdl, ALSA_DEVICE,SND_PCM_STREAM_PLAYBACK,
				SND_PCM_NONBLOCK);	
		break;
	default:
		break;
	}

	if (err < 0) {
		printf ("ERROR: ALSA/snd_pcm_open: Cannot open audio device (%s)\n",
						snd_strerror (err));
		return -1;
	}
	////////////////////////////////////////////////////////////////////////////
	// BEGIN DEVICE SETUP
	////////////////////////////////////////////////////////////////////////////
	// Allocate space for device configuration
	snd_pcm_hw_params_t	*hw_params;

	err = snd_pcm_hw_params_malloc (&hw_params);
	if (err < 0) {
		printf ("Cannot allocate hardware parameter structure (%s)\n",
				 snd_strerror (err));
		return -1;
	}

	// Init hwparams with full configuration space 
	if ((err = snd_pcm_hw_params_any (audio_hdl, hw_params)) < 0) {
		printf ("Cannot initialize hardware parameter structure (%s)\n",
				 snd_strerror (err));
		return -1;
	}

	err = snd_pcm_hw_params_set_access (audio_hdl, hw_params,
					SND_PCM_ACCESS_RW_INTERLEAVED);
	if (err < 0) {
		printf ("Cannot set access type (%s)\n", snd_strerror (err));
	}
	
	// Set sample formats (Signed, 16Bits, little endian)
	err = snd_pcm_hw_params_set_format (audio_hdl, hw_params,
					SND_PCM_FORMAT_S16_LE);
	if (err < 0) {
		printf ("Cannot set sample format (%s)\n", snd_strerror (err));
		return -1;
	} 
	
	unsigned int rate = SAMPLING_RATE;
	unsigned int exact_rate;

	exact_rate = rate;
	// Set sampling rate (8kHz)
	err = snd_pcm_hw_params_set_rate_near (audio_hdl, hw_params, 
			&exact_rate, 0);
	if (err < 0) {
		printf ("Cannot set sample rate (%s)\n", snd_strerror (err));
		return -1;
	}
	if (exact_rate != rate) {
      fprintf(stderr, "The rate %d Hz is not supported by your hardware.\n ==> Using %d Hz instead.\n", rate, exact_rate);
    }
	
	// Set number of channels - Mono(1) or Stereo(2) 
	err = snd_pcm_hw_params_set_channels (audio_hdl, hw_params, MONO);
	if (err < 0) {
		printf ("Cannot set channel count (%s)\n", snd_strerror (err));
		return -1;
	}
	
	// Apply previously setup parameters
	err = snd_pcm_hw_params (audio_hdl, hw_params);
	if (err < 0) {
		printf ("Cannot set parameters (%s)\n", snd_strerror (err));
		return -1;
	}
		
	// Free temp variable used for configuration.
	snd_pcm_hw_params_free (hw_params);
	////////////////////////////////////////////////////////////////////////////
	// END DEVICE SETUP
	////////////////////////////////////////////////////////////////////////////

	// Success
	devstate = DeviceOpened;
	return 0;
}

//////////////////////////////////////////////////////
// For PLAYBACK
// audio_buf is an object of audiobuffer class
// 		getData() : to get the data of the buffer
//		getSize() : to get the size of the buffer
/////////////////////////////////////////////////////
int
AudioDriversALSA::writeBuffer (void) {
	if (devstate != DeviceOpened) {
		printf ("ALSA: writeBuffer(): Device Not Open\n");
		return -1;
	}

	int rc;
	size_t count = audio_buf.getSize()/2;
	short *buf = (short*)audio_buf.getData();
	while (count > 0) {
		rc = snd_pcm_writei(audio_hdl, buf, count);
		if (rc == -EPIPE) {
			snd_pcm_prepare(audio_hdl);
		} else if (rc == -EAGAIN) {
			continue;
		} else if (rc < 0) {
			printf ("ALSA: write(): %s\n", strerror(errno));
			break; 
		}
		buf += rc;
		count -= rc;
	}	
	return rc;
}


//////////////////////////////////////////////////////
// For CAPTURE
/////////////////////////////////////////////////////
int
AudioDriversALSA::readBuffer (void *ptr, int bytes) {
	if( devstate != DeviceOpened ) {
		printf ("ALSA: readBuffer(): Device Not Open\n");
		return -1;
	}

	ssize_t count = bytes/2;
	ssize_t rc;

	do {
		rc = snd_pcm_readi(audio_hdl, (short*)ptr, count);
	} while (rc == -EAGAIN);
	if (rc == -EBADFD) printf ("Read: PCM is not in the right state\n");
	if (rc == -ESTRPIPE) printf ("Read: a suspend event occurred\n");
	if (rc == -EPIPE) {
			printf ("Read: -EPIPE %d\n", rc);
			snd_pcm_prepare(audio_hdl);
	}
	if (rc > 0 && rc != count) {
		printf("Read: warning: asked microphone for %d frames but got %d\n",
			count, rc);
	}

	return rc;
}


--0-490394957-1112304522=:25995--


-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
