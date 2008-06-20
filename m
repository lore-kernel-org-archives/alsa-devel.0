From: Joshua Boyd <jdboyd@jdboyd.net>
Subject: A few general questions (my first driver): Marian MARC4
Date: Fri, 20 Jun 2008 02:07:49 -0400
Message-ID: <FCDBA326-635A-4820-8F25-4377CB4A17A4@jdboyd.net>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from jdboyd.net (jdboyd.net [206.192.23.82])
	by alsa0.perex.cz (Postfix) with ESMTP id D3D5B2452D
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Jun 2008 08:07:55 +0200 (CEST)
Received: from [192.168.1.45] (pool-72-70-142-78.hrbgpa.east.verizon.net
	[72.70.142.78]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by jdboyd.net (Postfix) with ESMTP id 4878796D19
	for <alsa-devel@alsa-project.org>; Fri, 20 Jun 2008 02:10:01 -0400 (EDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I have a Marian Marc4 card.  I have the documentation for this card,  
which has been on their web site for quite some time.  I want to  
write a driver for this card.  This is my first ALSA driver, but it  
isn't my first kernel driver.

Anyway, I can't google any mention of this family of cards on this  
mailing list, which seems a bit odd.  I did find some mentions on  
linux-audio-developer, about the documentation, but no mention there  
of prior work on this family.

However, I did find a MARC8 driver on sourceforge (http:// 
sourceforge.net/projects/marc8-driver).  Does anyone know anything  
about this?  I'm vary curious about why I've never seen it mentioned  
here before.  The license is listed as GPL.  The Marian Marc8 was  
formerly known as the Sek'd Siena, but again I can't find any real  
mention of that in the archives.  Does anyone have any idea why the  
MARC8 wasn't mentioned and merged into the main ALSA sources?

I did go ahead and add some Marian product information to the support  
matrix on the alsa wiki, including a link to the sourceforge page.

My plan is to add MARC4 to the MARC8 driver.  The register layout is  
basically the same, adjusted for the 4 versus 8 channels.  Both cards  
use the same PLX chip.  The biggest difference is in the layout of  
the play/capture RAM area, which is because of the 4 versus 8  
channels.  It seems silly to make two separate drivers.  I would like  
to see my results eventually merged into the main ALSA.  I'm hoping  
that if I get these into the main tree that I would then be able to  
get some support from Marian in the form of clearance (and a card) to  
do the Trace D4 and D4 SRC, and possibly even documentation and  
hardware for the UCON CX.

Anyway, moving on to my specific questions.

First, is it appropriate to put support for two device IDs in the  
same file?  The examples I tried looking at ended up being a single  
device id, differentiated by a subvendor ID.

Second, is it wrong to use the same structures, but with an enum  
field in the main snd_marc device structure that points out which  
card I'm talking about, then else where switching on that enum to  
figure out how many channels I need to operate on?

Third, once I get this functional on my MARC4 card, how hard is it  
likely to be to get it accepted?  I don't expect low standards for  
code that is accepted, but I'd like to have some idea how picky the  
process may be.
