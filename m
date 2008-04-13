From: stan <ghjeold_i_mwee@cox.net>
Subject: Re: What does 0dB refer to? (Logitech USB Speakers)
Date: Sun, 13 Apr 2008 08:17:39 -0700
Message-ID: <48022413.5020706@cox.net>
References: <20080411204610.GA32413@tango.0pointer.de>	<480099C6.3040708@superbug.co.uk>	<20080412133536.GC32491@tango.0pointer.de>	<4800FC14.3060804@superbug.co.uk>	<20080412211456.GA2828@localhost>	<48012F8B.5010805@cox.net>	<20080412230014.GA3016@localhost>	<75b66ecd0804121624m308977dy752d7e7c41dd7ea3@mail.gmail.com>	<4801E5CA.7010408@superbug.co.uk>
	<4801F3F2.90008@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fed1rmmtao102.cox.net (fed1rmmtao102.cox.net [68.230.241.44])
	by alsa0.perex.cz (Postfix) with ESMTP id CAAAB24667
	for <alsa-devel@alsa-project.org>;
	Sun, 13 Apr 2008 17:17:41 +0200 (CEST)
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao102.cox.net
	(InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP id
	<20080413151738.CHHL13697.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>
	for <alsa-devel@alsa-project.org>; Sun, 13 Apr 2008 11:17:38 -0400
In-Reply-To: <4801F3F2.90008@keyaccess.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Rene Herman wrote:
> On 13-04-08 12:51, James Courtier-Dutton wrote:
>
>   
>> It seems to me that whatever way you look at this, A default value of 
>> "MUTE" is really the only safe level for all sound card types.
>>     
>
> Always good to be ignored. How about that card specific "defaults" setup 
> that I suggested?
>
> Rene
>
>   
I think this would theoretically work, but it requires creating and 
maintaining a database of all sound cards.  And if a card is not in the 
database, there still has to be a default behavior.  ;-)

Perhaps an entry could be added to the .asoundrc or asound.state file 
that sets this.  Although the main time this is of import is the first 
time a sound card is used, so there would have to be a default entry  
:-).  After that it retains its previous state and is not as important.

It looks like mute is a reasonable compromise, except for blind users.
