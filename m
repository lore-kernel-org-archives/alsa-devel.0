From: Patrick Shirkey <kotau@firstlinux.net>
Subject: Re: Fwd: Re: USB Quattro Linux support
Date: Mon, 15 Apr 2002 05:16:17 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020415121617.6442736F9@sitemail.everyone.net>
Reply-To: pshirkey@boosthardware.com
Mime-Version: 1.0
Content-Type: text/plain
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
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>, James@superbug.demon.co.uk
Cc: linux-audio-dev@music.columbia.edu, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--- Paul Davis <pbd@op.net> wrote:
>>>framework for ALSA worked out, which is even more of a problem. Its
>>>still unclear at this point whether the ALSA framework will be:
>>>
>>>      application<->alsa-lib<->alsa-driver<->low-level-ALSA-USB-class-driver
>>>
>>>OR
>>>
>>>      application<->alsa-lib<->low-level-non-ALSA-USB-class-driver
>>>
>>>the first one is easier to write, the second one is more flexible.
>>>


I think a good example of how ALSA should work with USB devices is the gphoto approach. From what I know of their framework it is along the same lines as the first option.

>
>the problem i alluded to is just one of making an architectural
>decision. do you consider USB Audio devices to be best supported by a
>kernel driver with a USB focus, or an ALSA focus? alsa-lib can handle
>either, but in the former case (USB focus), more code has to be
>written in user space, and the existing USB audio driver for OSS has
>to be moved out of OSS and made more generic.
>

I'm pretty sure that we would have the means currently to see the device through the usb port. (I'll need to test that out) The problem I see is how does ALSA access the kernels USB modules and once that is sorted out we need the specs for the devices. 

So how do we go about writing a "low-level-ALSA-USB-class-driver"?




--
Patrick Shirkey - Boost Hardware Ltd
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/Linux_Audio_Users_Guide/




>_______________________________________________
>Alsa-devel mailing list
>Alsa-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/alsa-devel

_____________________________________________________________
Want a new web-based email account ? ---> http://www.firstlinux.net

_____________________________________________________________
Run a small business? Then you need professional email like you@yourbiz.com from Everyone.net  http://www.everyone.net?tag
