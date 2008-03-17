From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [alsa-devel] /usr/share/alsa/alsa.conf :and file
	extention
Date: Mon, 17 Mar 2008 13:34:11 +0100
Message-ID: <47DE6543.9000909@keyaccess.nl>
References: <cab05a880803161957j7a82e04cma094afda62d5cdab@mail.gmail.com>	<47DDE2F7.7000904@keyaccess.nl>
	<s5hmyoxu66g.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-bounces@lists.sourceforge.net>
In-Reply-To: <s5hmyoxu66g.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-user-bounces@lists.sourceforge.net
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-user <alsa-user@lists.sourceforge.net>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 17-03-08 09:05, Takashi Iwai wrote:
> At Mon, 17 Mar 2008 04:18:15 +0100,
> Rene Herman wrote:

>> Don't do it there. Use /etc/asound.conf or $HOME/.asoundrc ...
> 
> Or /etc/asound.conf.  It's the additional place for the system-wide
> definitions.

That's what I said. What happened? Alexander also completely missed that...

>> Exactly why you need that slave definition I'm not sure either, but it seems 
>> you do.
> 
> The file plugin requires the slave for its configuration and as the
> timing source.  Using "null" is just to accept any config and feed the
> data as fast as possible.  If you need to save the data as if it's
> being played, use the kernel dummy driver as the slave.

I see, thanks.

>> Also note that /tmp/pcm.out will be headerless PCM and is recreated 
>> for individual opens. I don't believe there's an append mode or anything 
>> (and you'd need to make sure that everyone plays the same format) so not 
>> toot sure if this is what you need to have a catch all audio-sink...
> 
> Recently I added a new option "truncate" to file plugin.  As default,
> it's set to true (for compatibility reason), and the plugin overwrite
> the existing file if reopened.  When it's set to false, a new file is
> created with a different suffix (up to 1000 files) at each time.

That sounds useful...

Rene.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
