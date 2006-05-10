From: Hans-Christian Egtvedt <hcegtvedt@atmel.com>
Subject: Re: Request to change enums to int in alsa-lib
Date: Wed, 10 May 2006 15:28:09 +0200
Message-ID: <4461EA69.1040108@atmel.com>
References: <4461E0C5.3040305@atmel.com> <s5h1wv29fy3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h1wv29fy3.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Wed, 10 May 2006 14:47:01 +0200,
> Hans-Christian Egtvedt wrote:

<snip>

>> I have attached a patch which changes all enums into ints, and the
>> library now works for me. I have no idea if I have broken something
>> else. I have another issue, but I'll post that in a separate email.
> 
> The change to include/sound/*.h looks OK.  Actually, the kernel side
> was already fixed to use int.  I was too lazy to update the alsa-lib
> side.
> 
> But, are other changes really necessary?  They are local in alsa-lib,
> so the size shouldn't matter.

I don't have the complete insight of which structs are being used
towards the kernel and which are just internal, so I did the "easy" way
of search and replace the entire library. If you, or somebody else with
good knowledge of the alsa library, redo my patch to those only used for
communication towards the kernel I can give it a go and see if it's
still good.

-- 
With kind regards,
Med vennlig hilsen,

Hans-Christian Egtvedt
Applications Engineer - AVR Applications Lab
Atmel Norway


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
