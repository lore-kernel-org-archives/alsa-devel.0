From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: [Fwd: ALSA request]
Date: Wed, 07 Jul 2004 12:55:01 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40EBE495.6060007@superbug.demon.co.uk>
References: <40EBDCC2.7040807@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <40EBDCC2.7040807@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tg@egosys.net
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Patrick Shirkey wrote:
> We are more than happy to field your questions on the alsa devel list.
> 
> Regards.
> 
> 
> ------------------------------------------------------------------------
> 
> Subject:
> ALSA request
> From:
> "TG Kang" <tg@egosys.net>
> Date:
> Wed, 7 Jul 2004 16:59:22 +0900
> To:
> <pshirkey@boosthardware.com>
> 
> To:
> <pshirkey@boosthardware.com>
> 
> Return-path:
> <tg@egosys.net>
> Envelope-to:
> pshirkey@boosthardware.com
> Delivery-date:
> Wed, 07 Jul 2004 09:59:28 +0200
> Received:
> from [210.218.249.11] (helo=ns.egosys.net) by www3.webhosting.cx with 
> esmtp (Exim 4.34) id 1Bi7Kv-00083L-Jj for pshirkey@boosthardware.com; 
> Wed, 07 Jul 2004 09:59:26 +0200
> Received:
> from tg ([221.151.112.1]) by ns.egosys.net (8.11.2/8.11.2) with SMTP id 
> i6785V806568 for <pshirkey@boosthardware.com>; Wed, 7 Jul 2004 17:05:34 
> +0900
> Message-ID:
> <002d01c463f8$51d80f90$174d10ac@tg>
> MIME-Version:
> 1.0
> Content-Type:
> multipart/alternative; boundary="----=_NextPart_000_002A_01C46443.C06D1FE0"
> X-Priority:
> 3
> X-MSMail-Priority:
> Normal
> X-Mailer:
> Microsoft Outlook Express 6.00.2800.1409
> X-MimeOLE:
> Produced By Microsoft MimeOLE V6.00.2800.1409
> 
> 
>  
> Hi, 
> My company, Ego Systems Inc., is beginning to consider making our products compatible to ALSA. So far, we haven't made much effort to put our products into the Linux world for some reasons.
> We produce soundcards and audio interfaces targeted to both professional and regular consumers. If you don't have much information on this company and its products, looking at www.esi-pro.com will help.
> Now that the demand from inside and outside of this company arises, we are seriously willing to hook our products with linux/ALSA.
> I've read the 'Getting support for your hardware' section on ALSA website carefully, and got aware of what ALSA developers want from manufacturers.
> 
> Now, please give us more detailed procedure we need to take.
> If you are not the proper contact point regarding this request, please forward it to a proper person.
> 
> Personally, as one of the Linux 'freaks', I hope every Linux user can feel free to use our products.
> 
> Best regards,
> 
> /*
>  *                             
>  * Kang, Taegoo
>  *
>  * R&D dept. / Software Engineer
>  * Ego Systems Inc.                  
>  *
>  * phone: +82-2-2164-9832
>  *
>  * www.esi-pro.com 
>  *                            
>  */
> 

The first step is to publish datasheets on your products and have them 
publically downloadable from your web site.
These data sheets should contain as much about the sound card as 
possible. There should be enough information in the datasheet, so that 
anyone could write a driver for any operating system.
You currently have a WDM driver for windows. All the information about 
the card that was used to write the WDM driver should be in this datasheet.
If you could also publish the source code to the current WDM windows 
driver, that would also help, as source code combined with a datasheet 
makes for very good documentation.

Once you have all this information public, we can then move on to the 
next stage.

James


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
