From: =?ISO-8859-1?Q?Erik_Inge_Bols=F8?= <knan@mo.himolde.no>
Subject: Re: second repost: oops on intel8x0
Date: Thu, 14 Feb 2002 11:56:45 +0100 (CET)
Message-ID: <a4g5ne$um1$1@quimby2.netfonds.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20020214113226.A2103@shurdeek.cb.ac.at>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Peter Surda <shurdeek@panorama.sth.ac.at>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 14 Feb 2002, Peter Surda wrote:
>Hi!
>
>Finally an answer :-)
>
>On Thu, Feb 14, 2002 at 01:21:43AM +0100, Erik Inge Bolsø wrote:
>> <oopses snipped>
>> >After they happen, sound card remains silent and module blocked.
>> Decode the oopses with ksymoops, then we'll have a better chance of
>> figuring out what the problem is.
>Attached, all 4 oopses thru ksymoops -dd.

Eek, far too verbose, can't make heads nor tails of it. We assume ksymoops
works, we don't want its internal debugging as well.

Could you provoke a new oops, and before doing anything else do a
"dmesg | ksymoops" and send the output?

--
Erik I. Bolsø | email: <knan at mo.himolde.no>
The UNIX philosophy basically involves giving you enough rope to
hang yourself.  And then a couple of feet more, just to be sure.


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
