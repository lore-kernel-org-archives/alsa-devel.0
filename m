From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Realtek ALC286 SONY Vaio Pro 13 Ubuntu 13.10
Date: Wed, 02 Oct 2013 06:51:00 +0200
Message-ID: <524BA634.1010108@canonical.com>
References: <524652C0.5040207@uwo.ca> <52492D48.102@canonical.com>
 <524A67F1.5020300@uwo.ca> <524A6B88.2080802@canonical.com>
 <524B8139.2040309@uwo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CCC8264F47
 for <alsa-devel@alsa-project.org>; Wed,  2 Oct 2013 06:51:06 +0200 (CEST)
In-Reply-To: <524B8139.2040309@uwo.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Yuval Levy <ylevy@uwo.ca>, Kailang <kailang@realtek.com>, David Chen <david.chen@canonical.com>, Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, 1228689@bugs.launchpad.net
List-Id: alsa-devel@alsa-project.org

On 10/02/2013 04:13 AM, Yuval Levy wrote:
> On 10/01/2013 02:28 AM, David Henningsson wrote:
>> Ok. If things work without extra drivers from Sony or Realtek, then it
>> should be possible to get things working in Linux too without extra
>> information from these parties...
> 
> I have added this information to the bug report
> <https://bugs.launchpad.net/bugs/1228689>
> where I also post my comments so that they are more persistent and
> available to other users with similar issues.
> 
> 
>> Ok - given that 0x21 works as expected you should only need to do this
>> for pin 0x18.
> 
> All my testing was with doing this for both pins.  I only noticed now
> that I do not need to do this for pin 0x18.  I will try to o this only
> for pin 0x21 and reboot tomorrow.

Ok, cool. Notice that I wrote "do this for pin 0x18 only, not for pin
0x21", where as you replied "I'll do this for pin 0x21 only, not for pin
0x18".

0x18 is for input switching, 0x21 is for output switching. If you remove
jack detection, like you did, you will need to do this switching
manually, e g in pavucontrol or gnome sound settings. That is, when you
plug your headphone in, you need to manually select "Headphone" too, if
you don't, the result will probably be that you hear sound in both
headphones and speakers.

Anyway, let's guess that the high pitched sound, as well as the lack of
headset microphone input, is because your headset is OMTP and that the
Vaio only supports CTIA. That's my *guess*, but it could be wrong, and
it would be good to have this confirmed with a CTIA headset.


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
