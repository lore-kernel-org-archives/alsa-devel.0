From: "M. Ritscher" <mr203010spam@gmx.net>
Subject: Re: libasound dies on snd_pcm_open
Date: Thu, 13 Feb 2003 21:37:02 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200302132137.05827.mr203010spam@gmx.net>
References: <200302112147.45539.mr203010spam@gmx.net> <200302121848.23717.mr203010spam@gmx.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_uHAT+ZweXk0ql7M"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200302121848.23717.mr203010spam@gmx.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_uHAT+ZweXk0ql7M
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: clearsigned data
Content-Disposition: inline

Hi again,

seems I was following a red herring. My debugger mislead me.
The function 'snd_pcm_open()' isn't the culprit, it really dies here:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
int rc =3D 0;

int exactRate
     =3D snd_pcm_hw_params_set_rate_near (capture_handle, hw_params,=20
&uSampleRate, &rc);
	if(rc !=3D  0) {
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
With the following definitions, declarations:
unsigned int uSampleRate - value 16100;
snd_pcm_t *capture_handle;
snd_pcm_hw_params_t *hw_params;

//ALSA library
#define ALSA_PCM_NEW_HW_PARAMS_API
#include <alsa/asoundlib.h>

It never returns from the call to "snd_pcm_hw_params_set_rate_near" and the=
=20
cpu is maxing out.

What I'm doing wrong? I'm really clueless now.

You can see from the attached text file what I've been trying...


Any help really appreciated.

Thanks,

Meinhard
>

--Boundary-00=_uHAT+ZweXk0ql7M
Content-Type: text/x-c++src;
  charset="iso-8859-1";
  name="openAlsaDevice.cpp"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="openAlsaDevice.cpp"


int KCorrView::openALSADevice(){

	int rc = 0;
	snd_pcm_hw_params_t *hw_params;
	const char *cTemp = 0;
	//snd_pcm_access_t access = ;


	cTemp = sDevice.ascii();
	std::cerr <<  sDevice << std::endl;
	if ((rc = snd_pcm_open (&capture_handle, sDevice.ascii(),
														SND_PCM_STREAM_CAPTURE, 0)) < 0) {
		std::cerr << "cannot open audio device" << sDevice << snd_strerror (rc);
		return rc;
	}
/*	if ((rc = snd_pcm_hw_params_malloc (&hw_params)) < 0) {
		std::cerr << "cannot allocate hardware parameter structure" <<  snd_strerror (rc);
		return rc;
	} */

	snd_pcm_hw_params_alloca (&hw_params);
	
	if ((rc = snd_pcm_hw_params_any (capture_handle, hw_params)) < 0) {
		std::cerr << "cannot initialize hardware parameter structure" << snd_strerror (rc);
		return rc;
	}
	
	if ((rc = snd_pcm_hw_params_set_access (capture_handle, hw_params, SND_PCM_ACCESS_RW_INTERLEAVED)) < 0) {
		// cerr << "cannot set access type" << snd_strerror (rc);
		return rc;
	}
	if ((rc = snd_pcm_hw_params_set_format (capture_handle, hw_params, SND_PCM_FORMAT_S16_LE)) < 0) {
		std::cerr << "cannot set sample format " << snd_strerror (rc);
		return rc;
	}
	
	if ((rc = snd_pcm_hw_params_set_channels(capture_handle, hw_params, 2))  < 0) {
		std::cerr << "Could not set to stereo" << snd_strerror(rc) << std::endl;
		return rc;
	}

/*	int exactRate
	      = snd_pcm_hw_params_set_rate_near (capture_handle, hw_params, &uSampleRate, &rc);
	if(rc !=  0) {
		std::cerr << "Sample rate " << uSampleRate << "is'nt supported by your hardware. Using "
		 << exactRate << "Hz instaed. " << std::endl;
	}
	std::cout << "snd_pcm_hw_params_set_rate_near returned with:  " << exactRate << std::endl;
	*/

	unsigned int rrate = uSampleRate;
	if((rc = snd_pcm_hw_params_set_rate_near (capture_handle, hw_params, &rrate, 0)) < 0){
		std::cerr << "Failed to set sample rate: "<< uSampleRate <<  snd_strerror (rc);
	}
	if(rrate !=  uSampleRate) {
		std::cerr << "Sample rate " << uSampleRate << "is'nt supported by your hardware. Using "
		 << rrate << "Hz instaed. " << std::endl;
	}
	std::cout << "snd_pcm_hw_params_set_rate_near returned with:  " << rc << std::endl;


	if ((rc = snd_pcm_hw_params_set_channels (capture_handle, hw_params, 2)) < 0) {
		std::cerr << "cannot set channel count " << snd_strerror (rc);
		return rc;
	}
	if ((rc = snd_pcm_hw_params (capture_handle, hw_params)) < 0) {
		std::cerr << "cannot set parameters " << snd_strerror (rc);
		return rc;
	}
	snd_pcm_hw_params_free (hw_params);
	if ((rc = snd_pcm_prepare (capture_handle)) < 0) {
		std::cerr << "cannot prepare audio interface for use " << snd_strerror (rc);
		return rc;
	}

  std::cout << "successfully set up ALSA 0.9 device" << std::endl;

  char buf[512];
  long a;

	if ((a = snd_pcm_readi (capture_handle, buf, 128)) < 0) {
			std::cerr << "read from audio interface failed: " << snd_strerror (a) << std::endl;
			return -1;
	}
	/*
	for(int i=0; i <128; i++){
			std::cout << buf[i];
	}
	std::cout << "  " << std::endl;
	*/
	return rc;
}
--Boundary-00=_uHAT+ZweXk0ql7M--



-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
