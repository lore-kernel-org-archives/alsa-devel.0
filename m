From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: new alsa docs.
Date: Fri, 09 Aug 2002 00:56:12 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D52949C.6030706@boosthardware.com>
References: <Pine.LNX.4.44.0208061855490.23759-100000@yme.mo.himolde.no>
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
To: ALSA Development <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Does anybody know how to get all the text from a text area to post when 
it includes " and ' marks?

I am using stripslashes($var) to pass the variable between pages with 
success but when I do the final post if I use "" around the VALUE in the 
input line the text gets cut off at the first " or if I use '' the text 
gets cut off at the first '.

eg.

        <INPUT NAME='note' TYPE='hidden' VALUE="<?echo 
stripslashes($note); ?>">

or

        <INPUT NAME='note' TYPE='hidden' VALUE='<?echo 
stripslashes($note); ?>'>

This is the script I am using to mail the form. I suspect that the mail 
command at the very bottom is fscking it but I'm not sure how I can fix it.

----
<?

if ($extradoc) {
	$notename = $extradoc;
} else {
	$notename = $module;
	}


$MailToAddress = "pshirkey@boosthardware.com";
$MailSubject = "ALSA: doc notes additions";
     if (!$YourAddress) {
     $YourAddress = "Null";
     }
$Header = "The following has been submitted as a note for the 
documentation of $notename. Save this as 
/alsa-doc/additions/$notename.php3. If there is not a file already you 
may need to use the template. Don't forget to add any new pages to 
cvs.\n cvs add www/alsa-doc/additions/$notename.php3";
$Footer = "";

   	$Name =  (stripslashes($Name));
	$YourAddress = (stripslashes($YourAddress));
	$time = (stripslashes($time));
	$note = (stripslashes($note));

	

	$Message .= "		<table border=\"0\" cellpadding=\"4\" cellspacing=\"0\" 
width=\"620\">\n";
        $Message .= "		<tr valign=\"top\">\n";
        $Message .= "		<td bgcolor=\"#bed1be\" colspan=\"2\">\n";
        $Message .= "    		<table border=\"0\" cellpadding=\"2\" 
cellspacing=\"0\" width=\"620\">\n";
        $Message .= "    		<tr valign=\"top\"><td>\n";
        $Message .= "       		$Name   &nbsp &nbsp <a href=\"mailto: 
$YourAddress\">$YourAddress</a><br>\n";
        $Message .= "       		$time</td>\n";
        $Message .= "    		<td align=\"right\">\n";
        $Message .= "    		<br></td>\n";
        $Message .= "    		</tr>\n";
        $Message .= "    		<tr bgcolor=\"#f0f0f0\"><td colspan=\"2\">\n";
        $Message .= "    		<pre>\n";
        $Message .= 			$note;
        $Message .= "\n		</pre>\n";
        $Message .= "    		</td></tr>\n";
        $Message .= "    		</table>\n";
        $Message .= "		</td>\n";
        $Message .= "		</tr>\n";
        $Message .= "		</table>\n";



        	if ($Header) {
        	$Message = $Header."\n\n".$Message;
	}

        	if ($Footer) {
        	$Message .= "\n\n".$Footer;
        	}

        	mail("$MailToAddress", "$MailSubject", "$Message", "From: 
$YourAddress");
      ?>
----




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
