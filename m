From: Antti Boman <antti.boman@mindcom.fi>
Subject: Re: new alsa docs.
Date: Fri, 09 Aug 2002 09:25:49 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D53606D.3020201@mindcom.fi>
References: <Pine.LNX.4.44.0208061855490.23759-100000@yme.mo.himolde.no> <3D52949C.6030706@boosthardware.com>
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
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: ALSA Development <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Sorry if I didn't understand your problem, but here goes.

Patrick Shirkey wrote:
> Does anybody know how to get all the text from a text area to post when 
> it includes " and ' marks?
> 
> I am using stripslashes($var) to pass the variable between pages with 
> success but when I do the final post if I use "" around the VALUE in the 
> input line the text gets cut off at the first " or if I use '' the text 
> gets cut off at the first '.
> 
> eg.
> 
>        <INPUT NAME='note' TYPE='hidden' VALUE="<?echo 
> stripslashes($note); ?>">
> 
> or
> 
>        <INPUT NAME='note' TYPE='hidden' VALUE='<?echo 
> stripslashes($note); ?>'>

Those look the same to me, so I assume you meant the other one with 
citation marks.

Anyway, you should use htmlspecialchars() to turn the special characters 
interfering html markup (' # & < >) to html entities. So:

<INPUT NAME="note" TYPE="hidden" VALUE="<?echo 
htmlspecialchars(stripslashes($note)); ?>">

> $MailToAddress = "pshirkey@boosthardware.com";
> $MailSubject = "ALSA: doc notes additions";
>     if (!$YourAddress) {
>     $YourAddress = "Null";
>     }

Hmmm... you're testing $Youraddress for integer, was that the intention? 
If $Youraddress doesn't contain a number in the beginning of the string, 
it fails and $Youradddress turns to "Null".

I also assumed you're using PHP.

Tell me more if I got it completely wrong ;)

-a



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
