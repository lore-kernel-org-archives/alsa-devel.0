From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 1/4] ASoC: firmware: Add support for FW
 based kcontrols.
Date: Thu, 29 Nov 2012 12:08:18 +0000
Message-ID: <50B75032.2030502@ti.com>
References: <1353348765-6238-1-git-send-email-lrg@ti.com>
 <s5hsj85qw1n.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 173C326165D
 for <alsa-devel@alsa-project.org>; Thu, 29 Nov 2012 13:08:21 +0100 (CET)
In-Reply-To: <s5hsj85qw1n.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 19/11/12 18:36, Takashi Iwai wrote:
> At Mon, 19 Nov 2012 18:12:42 +0000,
> Liam Girdwood wrote:
>>
>> This patch adds initial support for firmware based kcontrols by allowing
>> soc.h to be included by any userspace firmware generation tools and assi=
gns
>> IDs to the standard ASoC kcontrol types using the kcontrol_new index and=
 IDs
>> to kcontrol get/put/info functions.
>>
>> Signed-off-by: Liam Girdwood <lrg@ti.com>
>
> The user-space headers are recently moved to include/uapi/sound, so
> this new stuff should follow that rule.
>
> For the sound stuff, the patch is queued for 3.8 in for-next branch.
> Please rebase on it.

Done, but I'm now seeing some type conflict errors when building my userspa=
ce =

tools (i.e. after moving to include uapi/sound/asound.h from sound/asound.h=
).

e.g.

#include <stdlib.h>
#include <uapi/sound/asound.h>

int main ()
{
}

gives :-

gcc uapi-test.c -I ~/source/linux.git/include
In file included from /home/lrg/source/linux.git/include/uapi/sound/asound.=
h:26:0,
                  from uapi-test.c:2:
/home/lrg/source/linux.git/include/linux/types.h:14:26: error: conflicting =

types for =91fd_set=92
In file included from /usr/include/x86_64-linux-gnu/sys/types.h:220:0,
                  from /usr/include/stdlib.h:320,
                  from uapi-test.c:1:
/usr/include/x86_64-linux-gnu/sys/select.h:76:5: note: previous declaration=
 of =

=91fd_set=92 was here
In file included from /home/lrg/source/linux.git/include/uapi/sound/asound.=
h:26:0,
                  from uapi-test.c:2:
/home/lrg/source/linux.git/include/linux/types.h:15:25: error: conflicting =

types for =91dev_t=92
In file included from /usr/include/stdlib.h:320:0,
                  from uapi-test.c:1:
/usr/include/x86_64-linux-gnu/sys/types.h:61:17: note: previous declaration=
 of =

=91dev_t=92 was here

etc.....

I'm guessing here you have this building already with uapi alsa-lib ? Altho=
ugh =

I cant see any alsa-lib changes in git to use the new header.

Thanks

Liam
