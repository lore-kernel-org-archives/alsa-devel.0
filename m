From: Ben Saylor <bensaylor@fastmail.fm>
Subject: Re: [Alsa-user] [newbie] Audiophile USB problems (100% noise)
Date: Mon, 15 Sep 2003 10:56:21 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200309151056.21304.bensaylor@fastmail.fm>
References: <200309141339.24660.moron@industrial.org>
 <200309141701.16700.bensaylor@fastmail.fm>
 <200309142224.08767.moron@industrial.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200309142224.08767.moron@industrial.org>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-user@lists.sourceforge.net
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I doubt this will be fixed soon, because it doesn't seem that anyone who 
has this card also has the knowledge+time+motivation to get it 
working.. :(

Takashi, Clemens:  would it be useful to ask M-Audio exactly how the 
Audiophile deviates from the spec?

Ben

On Sunday 14 September 2003 9:24 pm, moron wrote:
> On September 14, 2003 06:01 pm, Ben Saylor wrote:
> > 1.  make sure the snd-usb-audio module is unloaded (I do
> > /etc/init.d/ alsasound stop)
>
> Howdy and thanks for the response.
>
> I tried the above but I had the wonderful situation of being told
> that "alsa isn't running" followed by "alsa already running" when I
> then tried to start it.  I did try the plug and un-plug maneover and
> tailing /var/log/messages showed that the usb sound module was loaded
> but then nothing could access it (I forget the specific error but the
> usb sound driver got reloaded but pcm_ something or other gave an
> error).  It did make some rather cool reverbish noisescapes when
> trying to play with aplayer but since all files sounded pretty much
> the same that's not a very useful "feature".
>
> =)
>
> I also noticed that aplayer seemed to refuse to honour command like
> arguments, for example I could not get it to register any bit rate
> changes, format, etc.
>
> > 1.  The hardware doesn't fully comply with the USB Audio Device
> > Class Definition, and the quirks haven't all been figured out
>
> Any ideas on how to narrow this down or help the developers in
> solving the issues?  I've had to revert back to OSS since I like
> being able to listen to audio thank you very much.
>
> =)
>
> The development list archives aren't a lot of help nor are the online
> docs (these need a LOT of work, the WIKI was a lot more helpful
> though still unclear / misleading on some issues) which seem to have
> not been updated for a long time (I sent a note about the audiophile
> USB back in July and I see that it still is not listed and the
> companyitself is still mis-listed as the non-existant "Midiman").
>
> Anyway, thanks again for tips. . .I guess I will just have to wait
> until ALSA is a little more mature before giving it another try.
>
> Cheers



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
