From: vollmer.philipp@t-online.de (Philipp Vollmer)
Subject: Re: Alsa Programming Examples
Date: Sat, 8 Jun 2002 09:26:25 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200206080926.25082.do1ypv@linux>
References: <Pine.LNX.4.21.0206080040150.784-100000@summer.quitte>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_10MDYB0ZIHUHN7SHD4BF"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.21.0206080040150.784-100000@summer.quitte>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--------------Boundary-00=_10MDYB0ZIHUHN7SHD4BF
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> it seems params =3D=3D 0 when you're calling snd_pcm_hw_refine.
Hello,

Sorry but there is no codeline like snd_pcm_hw_refine in the example.
I will send you the file as an attachment.

Best regards=20

Philipp Vollmer
vollmer.philipp@t-online.de
--------------Boundary-00=_10MDYB0ZIHUHN7SHD4BF
Content-Type: text/x-csrc;
  charset="iso-8859-1";
  name="how1.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="how1.c"

      #include <stdlib.h>
      #include <alsa/asoundlib.h>
      
      main (int argc, char *argv[])
      {
           int i;
           char buf[4096];
           snd_pcm_t *playback_handle;
           snd_pcm_hw_params_t *hw_params;

           if ((playback_handle = snd_pcm_open (&playback_handle, "default", SND_PCM_STREAM_PLAYBACK, 0)) < 0) {
                 fprintf (stderr, "cannot open audio device %s\n", argv[1]);
                 exit (1);
           }
	   // snd_pcm_open (&playback_handle, pcm_name, SND_PCM_STREAM_PLAYBACK, 0)
           
           snd_pcm_hw_params_malloc (&hw_params);
           snd_pcm_hw_params_any (playback_handle, hw_params);
           snd_pcm_hw_params_set_access (playback_handle, hw_params, SND_PCM_ACCESS_RW_INTERLEAVED);
           snd_pcm_hw_params_set_format (playback_handle, hw_params, SND_PCM_FORMAT_S16_LE);
           snd_pcm_hw_params_set_rate_near (playback_handle, hw_params, 44100, 0);
	 //snd_pcm_hw_params_set_rate_near(playback_handle, hw_params, 44100, 0);
           snd_pcm_hw_params_set_channels (playback_handle, hw_params, 2);
           snd_pcm_hw_params (playback_handle, hw_params);
           snd_pcm_hw_params_free (hw_params);

           snd_pcm_prepare (playback_handle);

           for (i = 0; i < 10; ++i) {
                   snd_pcm_writei (playback_handle, buf, sizeof (buf));
		  //snd_pcm_writei (playback_handle, buf, nframes);
           }

           snd_pcm_close (playback_handle);
           exit (0);
     }


--------------Boundary-00=_10MDYB0ZIHUHN7SHD4BF--


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas - http://devcon.sprintpcs.com/adp/index.cfm?source=osdntextlink
