From: Bill Unruh <unruh@physics.ubc.ca>
Subject: Re: [alsa-devel] floating point exception in compiling
	alsa 1.0.14
Date: Mon, 20 Aug 2007 07:44:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0708200742470.22634@info.physics.ubc.ca>
References: <46C4E23A.5090000@gia.usb.ve>
	<Pine.LNX.4.64.0708162003310.22506@info.physics.ubc.ca>
	<s5hodh6nsev.wl%tiwai@suse.de> <200708171909.49451.mgerdau@tiscali.de>
	<Pine.LNX.4.64.0708171326210.9350@string.physics.ubc.ca>
	<s5h4piuo8xs.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-bounces@lists.sourceforge.net>
In-Reply-To: <s5h4piuo8xs.wl%tiwai@suse.de>
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
Cc: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 20 Aug 2007, Takashi Iwai wrote:

> At Fri, 17 Aug 2007 13:32:52 -0700 (PDT),
> Bill Unruh wrote:
>>
>> Iam trying to compile alsa 1.0.14 agains Mandriva Linux kernel 2.6.17-13mdv
>> And I get a floating point exception.
>>
>> I No idea how I get a floating point exception.
>
> It appears rather like a compiler internal error, or something to do
> with your toolchain.  It's hard to make the compiler giving such an
> error intentionally ;)
>

It seems to have bee some problem in the packaged fixdep in the kernel
source tree. I tried on another machine and everything worked fine. 
Sorry for the false alarm.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
