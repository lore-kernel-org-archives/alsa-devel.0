From: =?ISO-8859-1?Q?Erik_Inge_Bols=F8?= <knan@mo.himolde.no>
Subject: Re: crash with rc8
Date: Wed, 5 Mar 2003 11:43:22 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.50-xtra.0303051138010.31068-100000@yme.mo.himolde.no>
References: <1046859047.2847.6.camel@didjeridu.adsmr.co.za>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1046859047.2847.6.camel@didjeridu.adsmr.co.za>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alfp <alfp@adsmr.co.za>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 5 Mar 2003, alfp wrote:
>Also, dmesg gives me
>
>Unable to handle kernel NULL pointer dereference at virtual address 00000008
> printing eip:
>f8b410b7
>*pde = 00000000
>Oops: 0002
>CPU:    0
>EIP:    0010:[<f8b410b7>]    Not tainted
>EFLAGS: 00010296
>eax: f6384bd8   ebx: 00000000   ecx: 00000000   edx: f6384bd8
>esi: 00015888   edi: 00015888   ebp: f638c000   esp: f6277c5c
>ds: 0018   es: 0018   ss: 0018
>Process aplay (pid: 2288, stackpage=f6277000)
>Stack: 00000000 00000000 f63170f4 f6384ba0 f754b800 f8b561a3 f6384bd8 00015888
>       00000000 00000000 00000000 00000000 00000000 f63170e0 f6384ba0 f6277ce4
>       f8b66f21 f6384ba0 00015888 f754b800 00000000 f6277ce4 f6384ba0 f8b4b4e0
>Call Trace:    [<f8b561a3>] [<f8b66f21>] [<f8b4b4e0>] [<f8b4b594>] [<f8b4ed4a>]
>  [<c01b87b0>] [<c0129666>] [<c01563ff>] [<c0109627>]
>
>Code: c7 43 08 00 00 00 00 8b 02 83 f8 02 0f 84 97 00 00 00 83 f8
>
>(one for each crashed aplay)

Install ksymoops, run "dmesg | ksymoops" to decode the oopsen, send them
here so we can find out what's wrong. Could be alsa at fault, could be the
mandrake vendor kernel at fault. The first oops is usually the most
reliable.

Download and compile ksymoops from
http://www.kernel.org/pub/linux/utils/kernel/ksymoops/v2.4/
if you can't find it in a mandrake rpm.

--
Erik I. Bolsø | email: <knan at mo.himolde.no>
The UNIX philosophy basically involves giving you enough rope to
hang yourself.  And then a couple of feet more, just to be sure.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
