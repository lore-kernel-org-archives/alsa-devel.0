From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Audigy 2 support, was Re: alsa "Soundcard" support page
 on alsa-project.org
Date: Thu, 20 May 2004 02:56:35 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40AC1053.6000808@superbug.demon.co.uk>
References: <40ABEC93.9080309@superbug.demon.co.uk> <200405191644.14991.witzel.thomas@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200405191644.14991.witzel.thomas@comcast.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: witzel.thomas@comcast.net
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thomas Witzel wrote:
> What needs to be done in order to improve the Audigy 2 support ? If there is 
> anything that can be done by just implementing things that are not 
> implemented because of lack in human resources then I wouldn't mind 
> volunteering with some of my time.
> 

Getting some datasheets on how the Audigy 2 works.
More exactly, it has something called a P16V or P17 chip on the board 
that does all the 24bit 96khz audio stuff, and we know nothing about it, 
and so we can only do 48Khz 16bit, just like a SB Live. The SB Audigy2 
does has much better DACs than the SB Live, so their is some benefit in 
getting a SB Audigy 2, but currently not much.

We have been trying very hard to get Creative to release some 
datasheets, but things are taking a very long time.

So, if you have time, try to discover how the P16V chip works and tell us.

Cheers
James



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
