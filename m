From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] udev: Allow ALSA input jacks to be accessed by
 the current user
Date: Wed, 15 Jun 2011 20:46:09 +0200
Message-ID: <4DF8FDF1.1040900@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060705090906040605070702"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 4AB0224A4F
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Jun 2011 20:46:13 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112])
	by adelie.canonical.com with esmtp (Exim 4.71 #1 (Debian))
	id 1QWv6Q-0007va-1L
	for <alsa-devel@alsa-project.org>; Wed, 15 Jun 2011 18:46:10 +0000
Received: from c83-249-209-91.bredband.comhem.se ([83.249.209.91]
	helo=[192.168.8.102]) by youngberry.canonical.com with esmtpsa
	(TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.71)
	(envelope-from <david.henningsson@canonical.com>) id 1QWv6P-0008Vg-PI
	for alsa-devel@alsa-project.org; Wed, 15 Jun 2011 18:46:10 +0000
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

This is a multi-part message in MIME format.
--------------060705090906040605070702
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I know this is probably not the correct upstream, but I just wanted to 
run it through alsa-devel first to make sure that you don't think this 
is all madness. :-)

So, one missing piece for userspace (PulseAudio etc) to actually be able
to use the jack input devices that ALSA create, is that these devices
are accessible by root only. This patch makes the input device nodes
accessible by the same users that can access the sound card: the current
logged in user, as well as users in the audio group.

One thing I was thinking about, was that the udev-acl rule actually 
grants read-write access to the input device node, where probably only 
read access is needed. Is this dangerous?

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------060705090906040605070702
Content-Type: text/x-patch;
 name="0001-udev-Allow-ALSA-input-jacks-to-be-accessed-by-the-cu.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-udev-Allow-ALSA-input-jacks-to-be-accessed-by-the-cu.pa";
 filename*1="tch"

>From a45276437c8c3fe62fc001f43d715bfe931dd438 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Wed, 15 Jun 2011 20:36:16 +0200
Subject: [PATCH] udev: Allow ALSA input jacks to be accessed by the current user

One missing piece for userspace (PulseAudio etc) to actually be able
to use the jack input devices that ALSA create, is that these devices
are accessible by root only. This patch makes the input device nodes
accessible by the same users that can access the sound card: the current
logged in user, as well as users in the audio group.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 extras/input_id/input_id.c              |   23 +++++++++++++++++++++++
 extras/udev-acl/70-acl.rules            |    1 +
 rules/rules.d/60-persistent-input.rules |    1 +
 3 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/extras/input_id/input_id.c b/extras/input_id/input_id.c
index ba53df0..814ce8e 100644
--- a/extras/input_id/input_id.c
+++ b/extras/input_id/input_id.c
@@ -189,6 +189,25 @@ static void test_key (struct udev *udev,
 		puts("ID_INPUT_KEYBOARD=1");
 }
 
+static void test_sound (struct udev_device *dev,
+		        const unsigned long* bitmask_sw)
+{
+
+	struct udev_device *snd_dev;
+
+	/* Ensure parent is sound card */
+	snd_dev = udev_device_get_parent_with_subsystem_devtype(dev, "sound", NULL);
+	if (!snd_dev)
+		return;
+
+	/* Check that there is at least one relevant switch type */
+	if (test_bit(SW_HEADPHONE_INSERT, bitmask_sw) || 
+	    test_bit(SW_MICROPHONE_INSERT, bitmask_sw) || 
+	    test_bit(SW_LINEOUT_INSERT, bitmask_sw) || 
+	    test_bit(SW_VIDEOOUT_INSERT, bitmask_sw))
+		puts("ID_INPUT_SNDJACK=1");	    
+}
+
 static void help(void)
 {
 	printf("Usage: input_id [options] <device path>\n"
@@ -212,6 +231,7 @@ int main (int argc, char** argv)
 	unsigned long bitmask_abs[NBITS(ABS_MAX)];
 	unsigned long bitmask_key[NBITS(KEY_MAX)];
 	unsigned long bitmask_rel[NBITS(REL_MAX)];
+	unsigned long bitmask_sw[NBITS(SW_MAX)];
 
 	udev = udev_new();
 	if (udev == NULL)
@@ -272,10 +292,13 @@ int main (int argc, char** argv)
 	get_cap_mask (dev, "capabilities/abs", bitmask_abs, sizeof (bitmask_abs));
 	get_cap_mask (dev, "capabilities/rel", bitmask_rel, sizeof (bitmask_rel));
 	get_cap_mask (dev, "capabilities/key", bitmask_key, sizeof (bitmask_key));
+	get_cap_mask (dev, "capabilities/sw", bitmask_sw, sizeof (bitmask_sw));
 
 	test_pointers(bitmask_ev, bitmask_abs, bitmask_key, bitmask_rel);
 
 	test_key(udev, bitmask_ev, bitmask_key);
 
+	test_sound(dev, bitmask_sw);
+
 	return 0;
 }
diff --git a/extras/udev-acl/70-acl.rules b/extras/udev-acl/70-acl.rules
index 037349d..a6f54d9 100644
--- a/extras/udev-acl/70-acl.rules
+++ b/extras/udev-acl/70-acl.rules
@@ -25,6 +25,7 @@ SUBSYSTEM=="scsi_generic", SUBSYSTEMS=="scsi", ATTRS{type}=="4|5", TAG+="udev-ac
 
 # sound devices
 SUBSYSTEM=="sound", TAG+="udev-acl"
+SUBSYSTEM=="input", ENV{ID_INPUT_SNDJACK}=="1", TAG+="udev-acl"
 
 # ffado is an userspace driver for firewire sound cards
 SUBSYSTEM=="firewire", ENV{ID_FFADO}=="1", TAG+="udev-acl"
diff --git a/rules/rules.d/60-persistent-input.rules b/rules/rules.d/60-persistent-input.rules
index cd1de4e..d04c09e 100644
--- a/rules/rules.d/60-persistent-input.rules
+++ b/rules/rules.d/60-persistent-input.rules
@@ -12,6 +12,7 @@ ENV{ID_INPUT_MOUSE}=="?*", ENV{.INPUT_CLASS}="mouse"
 ENV{ID_INPUT_TOUCHPAD}=="?*", ENV{.INPUT_CLASS}="mouse"
 ENV{ID_INPUT_TABLET}=="?*", ENV{.INPUT_CLASS}="mouse"
 ENV{ID_INPUT_JOYSTICK}=="?*", ENV{.INPUT_CLASS}="joystick"
+ENV{ID_INPUT_SNDJACK}=="?*", ENV{.INPUT_CLASS}="sndjack", GROUP="audio"
 DRIVERS=="pcspkr", ENV{.INPUT_CLASS}="spkr"
 ATTRS{name}=="*dvb*|*DVB*|* IR *", ENV{.INPUT_CLASS}="ir"
 
-- 
1.7.4.1


--------------060705090906040605070702
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------060705090906040605070702--
