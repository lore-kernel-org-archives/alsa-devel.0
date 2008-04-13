From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: What does 0dB refer to? (Logitech USB Speakers)
Date: Sun, 13 Apr 2008 18:28:07 +0200
Message-ID: <48023497.70404@keyaccess.nl>
References: <20080411204610.GA32413@tango.0pointer.de>	<480099C6.3040708@superbug.co.uk>	<20080412133536.GC32491@tango.0pointer.de>	<4800FC14.3060804@superbug.co.uk>	<20080412211456.GA2828@localhost>	<48012F8B.5010805@cox.net>	<20080412230014.GA3016@localhost>	<75b66ecd0804121624m308977dy752d7e7c41dd7ea3@mail.gmail.com>	<4801E5CA.7010408@superbug.co.uk>	<4801F3F2.90008@keyaccess.nl>
	<48022413.5020706@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 93DAF2479E
	for <alsa-devel@alsa-project.org>;
	Sun, 13 Apr 2008 18:25:19 +0200 (CEST)
In-Reply-To: <48022413.5020706@cox.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: stan <ghjeold_i_mwee@cox.net>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 13-04-08 17:17, stan wrote:

> Rene Herman wrote:

>> On 13-04-08 12:51, James Courtier-Dutton wrote:
>>
>>   
>>> It seems to me that whatever way you look at this, A default value of 
>>> "MUTE" is really the only safe level for all sound card types.
>>>     
>> Always good to be ignored. How about that card specific "defaults" setup 
>> that I suggested?

> I think this would theoretically work, but it requires creating and 
> maintaining a database of all sound cards.  And if a card is not in the 
> database, there still has to be a default behavior.  ;-)

That default would just be "do nothing" -- ie, keep things muted as now.

> Perhaps an entry could be added to the .asoundrc or asound.state file 
> that sets this.  Although the main time this is of import is the first 
> time a sound card is used, so there would have to be a default entry  
> :-).  After that it retains its previous state and is not as important.
> 
> It looks like mute is a reasonable compromise, except for blind users.

For all I and most other sensible (and non-blind) people care, it is, but as 
James said, distributions disagree. Generally, it's possible to provide a 
set of reasonable "non-mute default" on a per card basis but ALSA is the 
only one that can do so. I don't believe that creating a default control 
settings file upon submission of a new driver would be unreasonable. We 
already have /usr/share/alsa/cards/<card>.conf as well. Keeping it in sync 
over changes to the driver might be a slight problem.

But, like you yourself conclude, in the end just changing nothing is the 
other option and that's something distribution disagree with. Not I...

Rene.
