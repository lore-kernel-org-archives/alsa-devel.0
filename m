From: sajeesh sidharthan <sajeesh.sidharthan@yahoo.com>
Subject: [ucm] Adding list for caching multiple opened control
	devices
Date: Sat, 22 Jun 2013 15:10:12 -0700 (PDT)
Message-ID: <1371939012.85385.YahooMailNeo@web121506.mail.ne1.yahoo.com>
References: <1371801284-31603-1-git-send-email-zonque@gmail.com>
 <1371801284-31603-2-git-send-email-zonque@gmail.com>
 <20130621150019.GZ27646@sirena.org.uk> <51C4916A.3080008@gmail.com>
Reply-To: sajeesh sidharthan <sajeesh.sidharthan@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm12.bullet.mail.ne1.yahoo.com (nm12.bullet.mail.ne1.yahoo.com
 [98.138.90.75]) by alsa0.perex.cz (Postfix) with ESMTP id 6F95D2619DB
 for <alsa-devel@alsa-project.org>; Sun, 23 Jun 2013 00:10:14 +0200 (CEST)
In-Reply-To: <51C4916A.3080008@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello.

I would like to contribute to alsa development. As a first step, I have mad=
e changes for caching control devices in ucm.

Please review the following changes and let me know if I can check in the c=
hanges and how to check in?


----------------------

diff --git a/src/ucm/main.c b/src/ucm/main.c
index 030c9b1..3219778 100644
--- a/src/ucm/main.c
+++ b/src/ucm/main.c
@@ -131,31 +131,33 @@ static int open_ctl(snd_use_case_mgr_t *uc_mgr,
=A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 const char *ctl_dev)
=A0{
=A0=A0=A0=A0 int err;
+=A0=A0=A0 struct list_head *pos;
+=A0=A0=A0 struct snd_ctl_list *snd_ctl;
=A0
-=A0=A0=A0 /* FIXME: add a list of ctl devices to uc_mgr structure and
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cache accesses for multiple opened ctl devi=
ces */
-=A0=A0=A0 if (uc_mgr->ctl_dev !=3D NULL && strcmp(ctl_dev, uc_mgr->ctl_dev=
) =3D=3D 0) {
-=A0=A0=A0 =A0=A0=A0 *ctl =3D uc_mgr->ctl;
-=A0=A0=A0 =A0=A0=A0 return 0;
-=A0=A0=A0 }
-=A0=A0=A0 if (uc_mgr->ctl_dev) {
-=A0=A0=A0 =A0=A0=A0 free(uc_mgr->ctl_dev);
-=A0=A0=A0 =A0=A0=A0 uc_mgr->ctl_dev =3D NULL;
-=A0=A0=A0 =A0=A0=A0 snd_ctl_close(uc_mgr->ctl);
-=A0=A0=A0 =

+=A0=A0=A0 list_for_each(pos, &uc_mgr->ctl_list) {
+=A0=A0=A0 =A0=A0=A0 snd_ctl =3D list_entry(pos, struct snd_ctl_list, list);
+=A0=A0=A0 =A0=A0=A0 if(!snd_ctl)
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 break;
+=A0=A0=A0 =A0=A0=A0 if(!strcmp(snd_ctl->ctl_dev, ctl_dev)) {
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 *ctl =3D snd_ctl->ctl;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 return 0;
+=A0=A0=A0 =A0=A0=A0 }
=A0=A0=A0=A0 }
=A0=A0=A0=A0 err =3D snd_ctl_open(ctl, ctl_dev, 0);
=A0=A0=A0=A0 if (err < 0)
=A0=A0=A0=A0 =A0=A0=A0 return err;
-=A0=A0=A0 uc_mgr->ctl_dev =3D strdup(ctl_dev);
-=A0=A0=A0 if (uc_mgr->ctl_dev =3D=3D NULL) {
-=A0=A0=A0 =A0=A0=A0 snd_ctl_close(*ctl);
-=A0=A0=A0 =A0=A0=A0 return -ENOMEM;
-=A0=A0=A0 }
-=A0=A0=A0 uc_mgr->ctl =3D *ctl;
+
+=A0=A0=A0 if (*ctl) {
+=A0=A0=A0 =A0=A0=A0 snd_ctl =3D malloc(sizeof(struct snd_ctl_list));
+=A0=A0=A0 =A0=A0=A0 snd_ctl->ctl_dev =3D strdup(ctl_dev);
+=A0=A0=A0 =A0=A0=A0 snd_ctl->ctl =3D *ctl;
+=A0=A0=A0 =A0=A0=A0 list_add_tail(&snd_ctl->list, &uc_mgr->ctl_list);
+=A0=A0=A0 }
+
=A0=A0=A0=A0 return 0;
=A0}
=A0
+
=A0static int execute_cset(snd_ctl_t *ctl, char *cset)
=A0{
=A0=A0=A0=A0 char *pos;
@@ -622,6 +624,7 @@ int snd_use_case_mgr_open(snd_use_case_mgr_t **mgr,
=A0=A0=A0=A0 INIT_LIST_HEAD(&uc_mgr->value_list);
=A0=A0=A0=A0 INIT_LIST_HEAD(&uc_mgr->active_modifiers);
=A0=A0=A0=A0 INIT_LIST_HEAD(&uc_mgr->active_devices);
+=A0=A0=A0 INIT_LIST_HEAD(&uc_mgr->ctl_list);
=A0=A0=A0=A0 pthread_mutex_init(&uc_mgr->mutex, NULL);
=A0
=A0=A0=A0=A0 uc_mgr->card_name =3D strdup(card_name);
diff --git a/src/ucm/ucm_local.h b/src/ucm/ucm_local.h
index 13e82da..86a51c7 100644
--- a/src/ucm/ucm_local.h
+++ b/src/ucm/ucm_local.h
@@ -82,6 +82,12 @@ struct dev_list {
=A0};
=A0
=A0
+struct snd_ctl_list {
+=A0=A0=A0 snd_ctl_t *ctl;
+=A0=A0=A0 char *ctl_dev;
+=A0=A0=A0 struct list_head list;
+};
+
=A0/*
=A0 * Describes a Use Case Modifier and it's enable and disable sequences.
=A0 * A use case verb can have N modifiers.
@@ -183,8 +189,8 @@ struct snd_use_case_mgr {
=A0=A0=A0=A0 pthread_mutex_t mutex;
=A0
=A0=A0=A0=A0 /* change to list of ctl handles */
-=A0=A0=A0 snd_ctl_t *ctl;
-=A0=A0=A0 char *ctl_dev;
+=A0=A0=A0 =

+=A0=A0=A0 struct list_head ctl_list;
=A0};
=A0
=A0#define uc_error SNDERR
diff --git a/src/ucm/utils.c b/src/ucm/utils.c
index 2def0b8..f18a2ac 100644
--- a/src/ucm/utils.c
+++ b/src/ucm/utils.c
@@ -99,6 +99,21 @@ void uc_mgr_free_value(struct list_head *base)
=A0=A0=A0=A0 }
=A0}
=A0
+
+void uc_mgr_free_ctl(struct list_head *base)
+{
+=A0=A0=A0 struct list_head *pos, *npos;
+=A0=A0=A0 struct snd_ctl_list *ctl_list;
+=A0=A0=A0 =

+=A0=A0=A0 list_for_each_safe(pos, npos, base) {
+=A0=A0=A0 =A0=A0=A0 ctl_list =3D list_entry(pos, struct snd_ctl_list, list=
);
+=A0=A0=A0 =A0=A0=A0 free(ctl_list->ctl_dev);
+=A0=A0=A0 =A0=A0=A0 snd_ctl_close(ctl_list->ctl);
+=A0=A0=A0 =A0=A0=A0 list_del(&ctl_list->list);
+=A0=A0=A0 =A0=A0=A0 free(ctl_list);
+=A0=A0=A0 }
+}
+
=A0void uc_mgr_free_dev_list(struct list_head *base)
=A0{
=A0=A0=A0=A0 struct list_head *pos, *npos;
@@ -220,12 +235,7 @@ void uc_mgr_free_verb(snd_use_case_mgr_t *uc_mgr)
=A0=A0=A0=A0 uc_mgr->active_verb =3D NULL;
=A0=A0=A0=A0 INIT_LIST_HEAD(&uc_mgr->active_devices);
=A0=A0=A0=A0 INIT_LIST_HEAD(&uc_mgr->active_modifiers);
-=A0=A0=A0 if (uc_mgr->ctl !=3D NULL) {
-=A0=A0=A0 =A0=A0=A0 snd_ctl_close(uc_mgr->ctl);
-=A0=A0=A0 =A0=A0=A0 uc_mgr->ctl =3D NULL;
-=A0=A0=A0 }
-=A0=A0=A0 free(uc_mgr->ctl_dev);
-=A0=A0=A0 uc_mgr->ctl_dev =3D NULL;
+=A0=A0=A0 uc_mgr_free_ctl(&uc_mgr->ctl_list);
=A0}
=A0
=A0void uc_mgr_free(snd_use_case_mgr_t *uc_mgr)




---------------------

Sajeesh
