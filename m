From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: ALSA: hda - Fix a regression of the
	position-buffer check
Date: Sun, 09 Oct 2011 07:17:42 +0200
Message-ID: <4E912E76.5040707@canonical.com>
References: <4E8F558A.2080600@canonical.com> <s5hr52ot1bo.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id 7F261244AE
	for <alsa-devel@alsa-project.org>;
	Sun,  9 Oct 2011 07:17:45 +0200 (CEST)
In-Reply-To: <s5hr52ot1bo.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 10/08/2011 09:00 AM, Takashi Iwai wrote:
> At Fri, 07 Oct 2011 21:39:54 +0200,
> David Henningsson wrote:
>>
>> Hi Takashi,
>>
>> The offending commit a810364a042 seems to be in v3.0-rc2 (according to
>> git describe),
>
> No, it's in 3.1-rc2.
>
> % git describe --contains a810364a
> v3.1-rc2~4^2~47^2~88

Sorry for the fuzz. I stand corrected.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
