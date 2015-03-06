From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - Make path_has_mixer() tristate
Date: Fri, 06 Mar 2015 11:20:22 +0100
Message-ID: <54F97F66.3040500@canonical.com>
References: <54f97b6b.2b113d67.bm000@wupperonline.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id B873526057F
 for <alsa-devel@alsa-project.org>; Fri,  6 Mar 2015 11:20:22 +0100 (CET)
In-Reply-To: <54f97b6b.2b113d67.bm000@wupperonline.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?windows-1252?Q?Ingo_Br=FCckl?= <ib@wupperonline.de>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, superquad.vortex2@gmail.com
List-Id: alsa-devel@alsa-project.org



On 2015-03-06 10:57, Ingo Br=FCckl wrote:
> Takashi Iwai wrote on Fri, 06 Mar 2015 10:38:49 +0100:
>
>> Even if you try parsing the topology at first with ignoring 0x15,
>> you'll need to add the path over 0x15 manually back to the
>> information.  Otherwise it can't work.
>
> Why can't it work? I'm not going to use the speaker.

There is no known hardware that has an speaker with no connection to it =

(and it would be a BIOS error if there was one), so it is not a priority =

(perhaps not even of interest) of the driver to support it.
Especially not as the option of using e g hdajackretask [1] to disable =

the speaker permanently is an easier and better way than starting to =

mess around with the connections and paths manually.

I understand that your intentions are good and that you want to help =

other users as well, and I don't want to scare you off, but in this case =

it seems to me like you have some private patches that makes the driver =

half broken, and then you want the official Linux kernel to fix up your =

private half broken scenario. Which doesn't really make sense.

-- =

David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic

[1] or the kernel interfaces that hdajackretask is a front-end for
