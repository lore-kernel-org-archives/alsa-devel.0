From: Patrick Shirkey <kotau@firstlinux.net>
Subject: Re: Fwd: Re: USB Quattro Linux support
Date: Mon, 15 Apr 2002 05:49:05 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020415124905.C37D73ECC@sitemail.everyone.net>
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
To: James Tappin <sjt@star.sr.bham.ac.uk>
Cc: linux-audio-dev@music.columbia.edu, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--- James Tappin <sjt@star.sr.bham.ac.uk> wrote:
>On Monday 15 Apr 2002 13:16, Patrick Shirkey wrote:
>> --- Paul Davis <pbd@op.net> wrote:
>> >>>framework for ALSA worked out, which is even more of a problem. Its
>> >>>still unclear at this point whether the ALSA framework will be:
>> >>>
>> >>>     
>> >>> application<->alsa-lib<->alsa-driver<->low-level-ALSA-USB-class-driver
>> >>>
>> >>>OR
>> >>>
>> >>>      application<->alsa-lib<->low-level-non-ALSA-USB-class-driver
>> >>>
>> >>>the first one is easier to write, the second one is more flexible.
>>
>> I think a good example of how ALSA should work with USB devices is the
>> gphoto approach. From what I know of their framework it is along the same
>> lines as the first option.
>
>I think a more exact description of the gphoto approach is:
>application<->gphoto-lib<->usb-lib<->low-level-generic-USB driver.
>
>Only the low-level kernel USB drivers and the usbdevfs filesystem are in 
>kernel space, beyond that the hardware driving is done via the user-space 
>libusb. I'm not sure whether this would have low-enough latency for audio 
>use, after all, digital cameras aren't timing-critical for the sort of things 
>that gphoto aims to do.
>
>

I think that there is support in gphoto for capturing video streams but I haven't used it so I don't know if that is correct. Anyway if I am correct then latency issues would have been solved already.

I will query with someone from their list and report back unless someone else knows for certain.

--
Patrick Shirkey - Boost Hardware Ltd
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/Linux_Audio_Users_Guide/



>-- 
>+------------------------+-------------------------------+---------+
>| James Tappin           | School of Physics & Astronomy |  O__    |
>| sjt@star.sr.bham.ac.uk | University of Birmingham      | --  \/` |
>| Ph: 0121-414-6462. Fax: 0121-414-3722                  |         |
>+--------------------------------------------------------+---------+
>
>_______________________________________________
>Alsa-devel mailing list
>Alsa-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/alsa-devel

_____________________________________________________________
Want a new web-based email account ? ---> http://www.firstlinux.net

_____________________________________________________________
Run a small business? Then you need professional email like you@yourbiz.com from Everyone.net  http://www.everyone.net?tag
