From: =?ISO-8859-1?Q?Erik_Inge_Bols=F8?= <knan@mo.himolde.no>
Subject: Re: ALSA AMD OOPS
Date: Thu, 21 Mar 2002 09:27:11 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0203210922270.28513-100000@yme.mo.himolde.no>
References: <E16nttv-0002RN-00@usw-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
In-Reply-To: <E16nttv-0002RN-00@usw-sf-list1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Mark Constable <markc@renta.net>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 21 Mar 2002, Mark Constable wrote:
>------
>Unable to handle kernel NULL pointer dereference at virtual address 00000000
> printing eip:
>c01112a3
>*pde = 00000000
>Oops: 0000
>CPU:    0
>EIP:    0010:[<c01112a3>]    Not tainted
>EFLAGS: 00010097
>eax: f693693c   ebx: f6936938   ecx: 00000000   edx: 00000003
>esi: f571cc08   edi: 00000001   ebp: f5909c84   esp: f5909c6c
>ds: 0018   es: 0018   ss: 0018
>Process alsamixer (pid: 333, stackpage=f5909000)
>Stack: f6fec8a0 f571cc08 f6fec8e8 f693693c 00000082 00000003 f6936920 f8883d61
>       f6936920 00000282 bffff5b0 f571cc08 f5909cfc f7718a00 f88847e1 f7718a00
>       00000001 f571cbc8 00000000 f7718a00 00000028 00000002 00000000 00000000
>Call Trace: [<f8883d61>] [<f88847e1>] [<c01395f7>] [<c0106d93>]
>
>Code: 8b 01 85 45 fc 74 4d 31 c0 9c 5e fa c7 01 00 00 00 00 83 79
> Segmentation fault

Does not tell us anything at all. Please, run the oops through ksymoops
<URL: ftp://ftp.us.kernel.org/pub/linux/utils/kernel/ksymoops/v2.4/ >
and resend.

--
Erik I. Bolsø | email: <knan at mo.himolde.no>
The UNIX philosophy basically involves giving you enough rope to
hang yourself.  And then a couple of feet more, just to be sure.


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
