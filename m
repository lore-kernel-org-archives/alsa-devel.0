From: william estrada <MrUmunhum@popdial.com>
Subject: USB device gives wrong data?
Date: Fri, 19 Oct 2007 14:44:08 -0700
Message-ID: <47192528.9080403@popdial.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-user-bounces@lists.sourceforge.net
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: linux-audio-user@lists.linuxaudio.org
Cc: alsa-user@lists.sourceforge.net, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi group,

   I think I have found a problem with the USB sound driver?  It appears
that the current drive returns a x'81' for silence but it should be a
x'7f'.

   When I use my laptop's sound device and record without a mic, I get
a file full of x'7f's.  If I do the same with my cheap-o USB device
I get a file full of x'81's.  The sound quality from the laptop is
unacceptable, so that is way I want to use the USB device.

   I have written a recording program that I have a 'silence' filter
that filters out segments of dead air.  It works with the laptop's
sound device but not the USB device.  The filter works by remove
x'7f's after allowing a selectable amount.  I get the results using
arecord which does not have the filtering.

   The USB device is a C -Media Electronics, Inc.  I am running FC6.

> [root@laptop ~]#  lsmod |grep snd
> snd_usb_audio          81985  0 
> snd_usb_lib            21057  1 snd_usb_audio
> snd_rawmidi            28481  1 snd_usb_lib
> snd_hwdep              13637  1 snd_usb_audio
> snd_ali5451            27853  1 
> snd_ac97_codec         99813  1 snd_ali5451
> snd_ac97_bus            6593  1 snd_ac97_codec
> snd_seq_dummy           8133  0 
> snd_seq_oss            37057  0 
> snd_seq_midi_event     11841  1 snd_seq_oss
> snd_seq                57009  5 snd_seq_dummy,snd_seq_oss,snd_seq_midi_event
> snd_seq_device         12365  4 snd_rawmidi,snd_seq_dummy,snd_seq_oss,snd_seq
> snd_pcm_oss            46433  0 
> snd_mixer_oss          20545  1 snd_pcm_oss
> snd_pcm                80965  4 snd_usb_audio,snd_ali5451,snd_ac97_codec,snd_pcm_oss
> snd_timer              26693  2 snd_seq,snd_pcm
> snd                    58181  140 snd_usb_audio,snd_rawmidi,snd_hwdep,snd_ali5451,snd_ac97_codec,snd_seq_oss,snd_seq,snd_seq_device,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
> soundcore              12193  1 snd
> snd_page_alloc         14281  1 snd_pcm

   Where do I report this 'bug' or how do I fix it?

   Thanks for your time.  Sorry for the multiple posting, not sure where is
should have gone.

-- 
William Estrada
MrUmunhum@popdial.com
Mt-Umunhum-Wireless.net ( http://Mt-Umunhum-Wireless.net )
Ymessenger: MrUmunhum


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
