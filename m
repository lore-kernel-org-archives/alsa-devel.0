From: "amidi@LEFerguson.com" <amidi@LEFerguson.com>
Subject: Re: Help with midi player application
Date: Fri, 17 Feb 2017 17:51:44 +0000
Message-ID: <BN6PR05MB30093D48EBAD32C1A98BA328D55D0@BN6PR05MB3009.namprd05.prod.outlook.com>
References: <BN6PR05MB3009207D0FB9108B1C1B052BD55D0@BN6PR05MB3009.namprd05.prod.outlook.com>
 <4c95ab4d-55a8-bbc7-f758-7022ab800440@ladisch.de>
 <BN6PR05MB3009240F07BF616C635EA8ABD55D0@BN6PR05MB3009.namprd05.prod.outlook.com>
 <010aad38-9842-7aad-f8b3-3956a76ec8ef@ladisch.de>
 <BN6PR05MB30093227CF6FB0511D20CE56D55D0@BN6PR05MB3009.namprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on0119.outbound.protection.outlook.com [104.47.36.119])
 by alsa0.perex.cz (Postfix) with ESMTP id 75E2C2671DB
 for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2017 18:51:46 +0100 (CET)
In-Reply-To: <BN6PR05MB30093227CF6FB0511D20CE56D55D0@BN6PR05MB3009.namprd05.prod.outlook.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Bingo.  It was entirely that.  I tracked back through the changes and let's just say it got tangled up in some confusion I had earlier about how I was going to start a song in the middle.  The documentation is correct; at the time I conflated the "realtime" and "absolute" aspects.  I changed this, and never revisited the relative time flag..

I quite literally just changed it to absolute instead of relative and it started working.  Obviously it was rescheduling the longer pieces based on an advancing clock.  Short pieces were dumped into the queue all essentially at tick 0.  With each "inhale" the next inhale was further delayed.  Makes sense now. 

Just need to clean up all the debugging and extra drains and such I put in.  :( 

Thank  you very much.

Linwood


>amidi@LEFerguson.com wrote:
>> I took the technique from what pmidi did
>
>AFAICS pmidi uses absolute timestamps.

Hmmm.... Starting to doubt my memory now... I see it does use a 0 in that parameter.  Not sure where I got using relative.  Let me go back and review.  Maybe I am scheduling the math incorrectly.

Thank you for emphasizing that.  I could have sworn I copied it from pmidi, but I must have changed at some point for some reason.  Need to rethink it.

More to follow...

Linwood

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
