From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: new alsa docs.
Date: Fri, 09 Aug 2002 15:52:52 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D5366C4.9050101@boosthardware.com>
References: <Pine.LNX.4.44.0208061855490.23759-100000@yme.mo.himolde.no> <3D52949C.6030706@boosthardware.com> <3D53606D.3020201@mindcom.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Antti Boman <antti.boman@mindcom.fi>
Cc: ALSA Development <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Antti Boman wrote:
> Sorry if I didn't understand your problem, but here goes.

You are right on the money. Now people can send full code examples 
without it getting chopped.

Thanks.

> <INPUT NAME="note" TYPE="hidden" VALUE="<?echo 
> htmlspecialchars(stripslashes($note)); ?>">
> 
>> $MailToAddress = "pshirkey@boosthardware.com";
>> $MailSubject = "ALSA: doc notes additions";
>>     if (!$YourAddress) {
>>     $YourAddress = "Null";
>>     }
> 
> 
> Hmmm... you're testing $Youraddress for integer, was that the intention? 
> If $Youraddress doesn't contain a number in the beginning of the string, 
> it fails and $Youradddress turns to "Null".
> 

oops. I haven't had any problems with it yet. It just adds NULL to the 
address of the sender which is the alsa server. It's no big deal.



-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
