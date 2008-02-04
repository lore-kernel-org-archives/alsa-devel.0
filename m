From: Jan Willies <jan@willies.info>
Subject: Re: [alsa-devel] em8300 and ALSA problems
Date: Mon, 04 Feb 2008 16:46:44 +0100
Message-ID: <47A73364.9060409@willies.info>
References: <47A7300D.3010907@willies.info> <s5h4pco3f56.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dxr3-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5h4pco3f56.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/dxr3-devel>,
	<mailto:dxr3-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=dxr3-devel>
List-Post: <mailto:dxr3-devel@lists.sourceforge.net>
List-Help: <mailto:dxr3-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/dxr3-devel>,
	<mailto:dxr3-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: dxr3-devel-bounces@lists.sourceforge.net
Errors-To: dxr3-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: dxr3-devel@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Mon, 04 Feb 2008 16:32:29 +0100,
> Jan Willies wrote:
>> [root@server ~]# alsaplayer --verbose -o alsa -d hw:1,0 Strong.mp3 
>> AlsaPlayer 0.99.80
>> (C) 1999-2004 Andy Lo A Foe <andy@alsaplayer.org> and others.
>> Output plugin: ALSA output v1.9.0beta12
>> error on set_format SND_PCM_FORMAT_S16
>> Unavailable hw params:
>> ACCESS:  RW_INTERLEAVED
>> FORMAT:  S16_BE
> 
> The device is supposed to be big-endian only.  Try plughw:1,0
> instead to convert endianness.

Yes, that seems to work! Only for analog output though. When I try with digital I get the same error again.

[jan@server ~]$ cat /proc/asound/devices 
  0: [ 0]   : control
  1:        : sequencer
 16: [ 0- 0]: digital audio playback
 24: [ 0- 0]: digital audio capture
 25: [ 0- 1]: digital audio capture
 32: [ 1]   : control
 33:        : timer
 48: [ 1- 0]: digital audio playback
 49: [ 1- 1]: digital audio playback

[root@server ~]# alsaplayer --verbose -o alsa -d plughw:1,1 Strong.mp3 
AlsaPlayer 0.99.80
(C) 1999-2004 Andy Lo A Foe <andy@alsaplayer.org> and others.
Output plugin: ALSA output v1.9.0beta12
error on set_format SND_PCM_FORMAT_S16
Unavailable hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  IEC958_SUBFRAME_BE
[...]

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
