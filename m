From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: [alsa-cvslog] CVS: alsa-kernel/pci/emu10k1 emufx.c,1.59,1.60
Date: Tue, 09 Nov 2004 00:12:19 +0000
Message-ID: <41900B63.30308@superbug.co.uk>
References: <E1CNAGJ-000270-L7@sc8-pr-cvs1.sourceforge.net> <418E654E.5000807@superbug.co.uk> <Pine.LNX.4.58.0411080734330.2162@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0411080734330.2162@pnote.perex-int.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Jaroslav Kysela <perex@users.sourceforge.net>, Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Sun, 7 Nov 2004, James Courtier-Dutton wrote:
> 
> 
>>2)
>> > +	if (put_user(x, &icode->code[a + 0]) ||
>> > +	    put_user(y, &icode->code[a + 1]))
>> > +		return -EFAULT;
>>
>>Will always return -EFAULT on my system. I don't think that is what we 
>>really want.
> 
> 
> Does this patch help?
> 

I have just tried the CVS, that includes your fixes.
Still returns -EFAULT.
At least the kernel module loads, but, no DSP code is installed.

James



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
