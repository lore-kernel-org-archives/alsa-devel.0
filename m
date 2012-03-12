From: Arvin Schnell <aschnell@suse.de>
Subject: Two patches for Python bindings
Date: Mon, 12 Mar 2012 14:16:31 +0100
Message-ID: <20120312131631.GA15612@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="xHFwDpU9dbj6ez1V"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id DF1F724491
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 14:16:33 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 65D2794373
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 14:16:33 +0100 (CET)
Content-Disposition: inline
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


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

please integrate the two attached patches in ALSA. The first one
fixes get_volume_array of the Python bindings for mono channels
(also reported as bug 5546). The second just updates one of the
pyalsa tests (apparently function names changed some time ago).

Regards,
  Arvin

--=20
Arvin Schnell, <aschnell@suse.de>
Senior Software Engineer, Research & Development
SUSE LINUX Products GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imend=F6rf=
fer, HRB 16746 (AG N=FCrnberg)
Maxfeldstra=DFe 5
90409 N=FCrnberg
Germany

--xHFwDpU9dbj6ez1V
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="pyalsa-mixer.diff"

diff --git a/pyalsa/alsamixer.c b/pyalsa/alsamixer.c
index d686f16..662a2a9 100644
--- a/pyalsa/alsamixer.c
+++ b/pyalsa/alsamixer.c
@@ -627,7 +627,7 @@ pyalsamixerelement_getvolumearray(struct pyalsamixerelement *pyelem, PyObject *a
 				return NULL;
  			res = snd_mixer_selem_get_playback_volume(pyelem->elem, SND_MIXER_SCHN_MONO, &val);
  			if (res >= 0)
- 				PyTuple_SetItem(t, 0, PyInt_FromLong(val));
+				PyList_SetItem(t, 0, PyInt_FromLong(val));
 		} else {
 			t = PyList_New(SND_MIXER_SCHN_LAST+1);
 			if (!t)
@@ -658,7 +658,7 @@ pyalsamixerelement_getvolumearray(struct pyalsamixerelement *pyelem, PyObject *a
 				return NULL;
  			res = snd_mixer_selem_get_capture_volume(pyelem->elem, SND_MIXER_SCHN_MONO, &val);
  			if (res >= 0)
- 				PyTuple_SET_ITEM(t, 0, PyInt_FromLong(val));
+				PyList_SET_ITEM(t, 0, PyInt_FromLong(val));
 		} else {
 			t = PyList_New(SND_MIXER_SCHN_LAST+1);
 			if (!t)

--xHFwDpU9dbj6ez1V
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="pyalsa-test.diff"

diff --git a/test/mixertest2.py b/test/mixertest2.py
index 24e5605..6c2d026 100755
--- a/test/mixertest2.py
+++ b/test/mixertest2.py
@@ -10,25 +10,25 @@ import select
 def parse_event_mask(events):
 	if events == 0:
 		return 'None'
-	if events == alsamixer.EventMaskRemove:
+	if events == alsamixer.event_mask_remove:
 		return 'Removed'
 	s = ''
-	for i in alsamixer.EventMask.keys():
-		if events & alsamixer.EventMask[i]:
+	for i in alsamixer.event_mask.keys():
+		if events & alsamixer.event_mask[i]:
 			s += '%s ' % i
 	return s[:-1]
 
 def event_callback(element, events):
 
 	print 'CALLBACK (DEF)! [%s] %s:%i' % (parse_event_mask(events), element.name, element.index)
-	print '  ', element.getVolumeTuple(), element.getSwitchTuple()
+	print '  ', element.get_volume_tuple(), element.get_switch_tuple()
 
 
 class MyElementEvent:
 
 	def callback(self, element, events):
 		print 'CALLBACK (CLASS)! [%s] %s:%i' % (parse_event_mask(events), element.name, element.index)
-		print '  ', element.getVolumeTuple(), element.getSwitchTuple()
+		print '  ', element.get_volume_tuple(), element.get_switch_tuple()
 
 
 mixer = alsamixer.Mixer()
@@ -36,13 +36,13 @@ mixer.attach()
 mixer.load()
 
 element1 = alsamixer.Element(mixer, "Front")
-element1.setCallback(event_callback)
+element1.set_callback(event_callback)
 element2 = alsamixer.Element(mixer, "PCM")
-element2.setCallback(MyElementEvent())
+element2.set_callback(MyElementEvent())
 
 poller = select.poll()
-mixer.registerPoll(poller)
+mixer.register_poll(poller)
 while True:
 	poller.poll()
 	print 'Poll OK!'
-	mixer.handleEvents()
+	mixer.handle_events()

--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--xHFwDpU9dbj6ez1V--
