From: Lucas Correia Villa Real <lucasvr@gobolinux.org>
Subject: Re: Invalid argument with snd_pcm_hw_params
Date: Sat, 17 May 2003 14:29:45 -0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200305171429.46219.lucasvr@gobolinux.org>
References: <200305171300.06149.lucasvr@gobolinux.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200305171300.06149.lucasvr@gobolinux.org>
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

Sorry, I forgot to post my system information.
I'm running Linux 2.4.20 with ALSA-Lib 0.9.2. The ALSA-driver I'm running is 
0.9.1, but I've got the same problems with 0.9.2.
I'm trying it with a Creative Labs SB Live! EMU10k1 card.

Thanks,
Lucas


On Saturday 17 May 2003 13:02, Lucas Correia Villa Real wrote:
> Hi,
>
> I'm porting one application of mine that used OSS, but I'm in trouble with
> the 'invalid argument' message I always get when calling
> snd_pcm_hw_params(). Also, I couldn't use buffers of 1024 bytes: it aborts
> on
> snd_pcm_hw_params_set_period_size() with the same error.
> Attached follows the relevant portion of the code.
> Some definitions used on the code:
>
> from my alsa.h file:
> #define DSP_BUFFER_SIZE        2048
> #define MONO                      1
> #define STEREO                    2
> #define AUDIO_DEVICE   "plughw:0,0"
>
> Thanks a lot for your attention. Any help is very appreciated.
> Lucas



-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
