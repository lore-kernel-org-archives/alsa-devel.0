From: Borg Onion <borg.onion@gmail.com>
Subject: snd_ctl_card_info_t type does not resolve on ubuntu
	11.10?
Date: Tue, 15 Nov 2011 05:10:05 -0800
Message-ID: <CAAs5ODuR235O9GTcuJqUGg1+5UnQnOeed=cBck7oh3_71H5k0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id EE0811038B8
	for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2011 14:10:09 +0100 (CET)
Received: by ywp27 with SMTP id 27so6107296ywp.38
	for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2011 05:10:07 -0800 (PST)
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

Hello,

Starting to write an ALSA app and trying to just list sound card info.  The
type "snd_ctl_card_info_t" doesn't seem to resolve by just including
<alsa/asoundlib.h>.  This type is needed for me to
call snd_ctl_card_info().  OS is Ubuntu 11.10 with libasound2-dev
installed.  What am I doing wrong?  Code is below:

#include <stdio.h>
#include <alsa/asoundlib.h>

void print_card_info(snd_ctl_card_info_t info)
{
        printf("Card #=3D%d, id=3D%s, driver=3D%s, name=3D%s, longname=3D%s,
mixername=3D%s, components=3D%s\n",
                info.card, info.id, info.driver, info.name, info.longname,
info.mixername, info.components);
}

int main(int argc, char **argv)
{
        int card =3D -1;
        char cardascii[3];
        char *name, *longname;
        snd_ctl_t *handle;
        snd_ctl_card_info_t info;

        while (snd_card_next(&card) >=3D 0) {
                if (card < 0) {
                        printf("No more cards!\n");
                        break;
                }
                printf("Card %d\n", card);
                if (snd_card_get_name(card, &name))
                {
                        printf("Error getting card %d's name, skipping\n",
card);
                        continue;
                }
                printf("Name =3D %s\n", name);
                if (snd_card_get_longname(card, &longname))
                {
                        printf("Error getting card %d's long name,
skipping\n", card);
                        continue;
                }
                printf("Long name =3D %s\n", longname);
                snprintf(cardascii, sizeof(cardascii), "%d", card);
                if (snd_ctl_open(&handle, cardascii, 0))
                {
                        printf("Error opening card #%d, skipping\n", card);
                        continue;
                }
                if (snd_ctl_card_info(handle, &info))
                {
                        printf("Error getting info for card #%d,
skipping\n", card);
                        snd_ctl_close(handle);
                        continue;
                }
                print_card_info(info);
                snd_ctl_close(handle);
        }

        return 0;
}

$ make
mkdir .deps
cc -O2 -std=3Dgnu99 -Wall -Wextra -pedantic -g   -c -DPREFIX=3D\"/usr/local=
\"
-Wp,-MD,.deps/list.d -o list.o list.c
list.c:4:42: error: parameter 1 (=E2info=E2) has incomplete type
list.c: In function =E2print_card_info=E2:
list.c:4:42: warning: unused parameter =E2info=E2 [-Wunused-parameter]
list.c: In function =E2main=E2:
list.c:16:22: error: storage size of =E2info=E2 isn=E2t known
list.c:16:22: warning: unused variable =E2info=E2 [-Wunused-variable]
list.c:10:14: warning: unused parameter =E2argc=E2 [-Wunused-parameter]
list.c:10:27: warning: unused parameter =E2argv=E2 [-Wunused-parameter]
make: *** [list.o] Error 1
