From: Garrett Kajmowicz <gkajmowi@tbaytel.net>
Subject: Segfault after 2 seconds
Date: Sun, 13 Jul 2003 11:19:08 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200307131119.08324.gkajmowi@tbaytel.net>
Reply-To: gkajmowi@tbaytel.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

I am working on an app which must change the configuration for sample rate on 
the fly.  I have produced code which seems to work.  However, for some 
reason, the app doing capturing runs only for about 2 seconds after capturing 
begins, at which point the app crashes with a segfault.  This is due to the 
sampling, and in fact changing of the hwparams because if I comment out the 
code which does that, I am able to sample continuously, which does not 
satisfy my needs.

The code attached executes flawlessly.  However, approximately two seconds 
after executing it, I get teh segault with no explanation.

I am using the plughw device so as to allow a lot of this stuff to happen in 
software for me.

I would appreciate any suggestions or refferences that you can point me to.

Garrett Kajmowicz
gkajmowi@tbaytel.net

Initial initialization code for the device:

		std::cout << "Initializting capture device\n";
		stream = SND_PCM_STREAM_CAPTURE;
		pcm_name = strdup("plughw:0");
		snd_pcm_hw_params_alloca(&hwparams);
		int retval;
		int retdir;

		if ((retval = snd_pcm_open(&pcm_handle, pcm_name, stream, SND_PCM_NONBLOCK)) 
< 0) {
			return;
		}
		if (snd_pcm_hw_params_any(pcm_handle, hwparams) < 0) {
			return;
	        }
		if (snd_pcm_hw_params_set_access(pcm_handle, hwparams, 
SND_PCM_ACCESS_MMAP_INTERLEAVED) < 0) {
			return;
		}
		if (snd_pcm_hw_params_set_format(pcm_handle, hwparams, 
SND_PCM_FORMAT_S16_LE) < 0) {
			return;
		}
		retdir = 0;
		snd_pcm_hw_params_set_rate_near(pcm_handle, hwparams, 16000, &retdir);

		if (snd_pcm_hw_params_set_channels(pcm_handle, hwparams, 1) < 0) {
			return;
		}

		if (snd_pcm_hw_params(pcm_handle, hwparams) < 0) {
			return;
		}



The code section used to change the settings is as follows:
			The stream, pcm_handle and the hwparams are teh same objects as above; 
global object

			if(snd_pcm_drop(pcm_handle)<0){
				std::cout << "PCM drop failed\n";
			}else{
				std::cout <<"PCM drop succeded\n";
			}

			if(snd_pcm_close(pcm_handle)<0){
				std::cout << "PCM close failed\n";
			}else{
				std::cout << "PCM close succeded\n";
			}

			std::cout << "Opening PCM device" << std::endl;

			if (snd_pcm_open(&pcm_handle, pcm_name, stream, SND_PCM_NONBLOCK) < 0) {
				std::cout <<"pcm_open failed\n";
				return;
			}else{
				std::cout << "PCM open succeded\n";
			}
			
			if(snd_pcm_hw_params_any(pcm_handle, hwparams) < 0){
				std::cout << "Error setting snd_pcm_hw_params_any";
			}else{
				std::cout << "Succeded setting params_any\n";
			}
			if(snd_pcm_hw_params_set_access(pcm_handle, hwparams, 
SND_PCM_ACCESS_MMAP_INTERLEAVED)<0){
				std::cout << "Error setting access mode\n";
			}else{
				std::cout << "Succeded setting access mode\n";
			}

			if (snd_pcm_hw_params_set_channels(pcm_handle, hwparams, 1) < 0) {
				return;
			}else{
				std::cout <<"Channels set for recording\n";
			}

			std::cout << "Setting sample rate\n";
			retdir=0;

			std::cout << "Sample rate set to: " << 
snd_pcm_hw_params_set_rate_near(pcm_handle, hwparams, currentSampleRate, 
&retdir) << std::endl;

			std::cout <<"Setting data format\n";

			//SNIP - doing a lot of comparisons to see what data format to select. 
			//Sample code:
			snd_pcm_hw_params_set_format(pcm_handle, hwparams, SND_PCM_FORMAT_U8);
			//End of SNIP

			if (snd_pcm_hw_params(pcm_handle, hwparams) < 0) {
				std::cout << "***Error setting playback HW params";
				return;
			} else{
				std::cout << "Update of hwparams succeded\n";
			}



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
