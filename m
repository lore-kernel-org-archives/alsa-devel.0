From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 13/13] libhinawa: add sample scripts
Date: Sun, 25 Jan 2015 20:34:34 +0900
Message-ID: <1422185674-16431-14-git-send-email-o-takashi@sakamocchi.jp>
References: <1422185674-16431-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1422185674-16431-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This commit adds some sample scripts written by Python 2/3.
In Python, PyGObject is required for GObject Introspection library.

There're three scripts, using Gtk+, Qt4 and Qt5. Each of them require
python bindings as:
 - PyGObject
 - PyQt4
 - PyQt5

I note that most of methods in libhinawa require 32bit array as its
method arguments. In Python, 'array' module is useful but the actual
width of the array element depents on machine architecture. Please
refer to sample scripts to solve this issue.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 libhinawa/README          |  10 +++
 libhinawa/samples/gtk3.py | 190 ++++++++++++++++++++++++++++++++++++++++++
 libhinawa/samples/qt4.py  | 206 ++++++++++++++++++++++++++++++++++++++++++++++
 libhinawa/samples/qt5.py  | 192 ++++++++++++++++++++++++++++++++++++++++++
 libhinawa/samples/run.sh  |  15 ++++
 5 files changed, 613 insertions(+)
 create mode 100755 libhinawa/samples/gtk3.py
 create mode 100755 libhinawa/samples/qt4.py
 create mode 100755 libhinawa/samples/qt5.py
 create mode 100755 libhinawa/samples/run.sh

diff --git a/libhinawa/README b/libhinawa/README
index 42d31f5..4e3c92c 100644
--- a/libhinawa/README
+++ b/libhinawa/README
@@ -18,3 +18,13 @@ How to refer document
  $ ./configure --enable-gtk-doc
  $ make
  $ make install
+
+How to test
+(needless to install)
+ $ ./autogen.sh
+ $ ./configure
+ $ make
+ $ ./samples/run.sh [gtk|qt4|qt5]
+gtk - PyGObject is required.
+qt4 - PyQt4 is required (also test python2).
+qt5 - PyQt5 is required.
diff --git a/libhinawa/samples/gtk3.py b/libhinawa/samples/gtk3.py
new file mode 100755
index 0000000..41a817e
--- /dev/null
+++ b/libhinawa/samples/gtk3.py
@@ -0,0 +1,190 @@
+#!/usr/bin/env python3
+
+import sys
+
+# Gtk+3 gir
+from gi.repository import Gtk
+
+# Hinawa-1.0 gir
+from gi.repository import Hinawa
+
+from array import array
+
+# helper function
+def get_array():
+    # The width with 'L' parameter is depending on environment.
+    arr = array('L')
+    if arr.itemsize is not 4:
+        arr = array('I')
+    return arr
+
+# query sound devices
+index = -1
+while True:
+    try:
+        index = Hinawa.UnitQuery.get_sibling(index)
+    except Exception as e:
+        break
+    break
+
+# no fw sound devices are detected.
+if index == -1:
+    print('No sound FireWire devices found.')
+    sys.exit()
+
+# get unit type
+try:
+    unit_type = Hinawa.UnitQuery.get_unit_type(index)
+except Exception as e:
+    print(e)
+    sys.exit()
+
+# create sound unit
+def handle_lock_status(snd_unit, status):
+    if status:
+        print("streaming is locked.");
+    else:
+        print("streaming is unlocked.");
+if unit_type == 1:
+    snd_unit = Hinawa.SndDice()
+elif unit_type == 2:
+    snd_unit = Hinawa.SndEfw()
+elif unit_type == 3 or unit_type == 4:
+    snd_unit = Hinawa.SndUnit()
+path = "hw:{0}".format(index)
+try:
+    snd_unit.open(path)
+except Exception as e:
+    print(e)
+    sys.exit()
+print('Sound device info:')
+print(' type:\t{0}'.format(snd_unit.get_property("type")))
+print(' card:\t{0}'.format(snd_unit.get_property("card")))
+print(' device:\t{0}'.format(snd_unit.get_property("device")))
+print(' GUID:\t{0:016x}'.format(snd_unit.get_property("guid")))
+snd_unit.connect("lock-status", handle_lock_status)
+
+# create FireWire unit
+def handle_bus_update(snd_unit):
+	print(snd_unit.get_property('generation'))
+snd_unit.connect("bus-update", handle_bus_update)
+
+# start listening
+try:
+    snd_unit.listen()
+except Exception as e:
+    print(e)
+    sys.exit()
+
+# create firewire responder
+resp = Hinawa.FwResp()
+def handle_request(resp, tcode, req_frame):
+    print('Requested with tcode {0}:'.format(tcode))
+    for i in range(len(req_frame)):
+        print(' [{0:02d}]: 0x{1:08x}'.format(i, req_frame[i]))
+    # Return no data for the response frame
+    return None
+try:
+    resp.register(snd_unit, 0xfffff0000d00, 0x100)
+    resp.connect('requested', handle_request)
+except Exception as e:
+    print(e)
+    sys.exit()
+
+# create firewire requester
+req = Hinawa.FwReq()
+
+# Fireworks/BeBoB/OXFW supports FCP and some AV/C commands
+if snd_unit.get_property('type') is not 1:
+    request = bytes([0x01, 0xff, 0x19, 0x00, 0xff, 0xff, 0xff, 0xff])
+    try:
+        response = snd_unit.fcp_transact(request)
+    except Exception as e:
+        print(e)
+        sys.exit()
+    print('FCP Response:')
+    for i in range(len(response)):
+        print(' [{0:02d}]: 0x{1:02x}'.format(i, response[i]))
+
+# Echo Fireworks Transaction
+if snd_unit.get_property("type") is 2:
+    args = get_array()
+    args.append(5)
+    try:
+        params = snd_unit.transact(6, 1, args)
+    except Exception as e:
+        print(e)
+        sys.exit()
+    print('Echo Fireworks Transaction Response:')
+    for i in range(len(params)):
+        print(" [{0:02d}]: {1:08x}".format(i, params[i]))
+
+# Dice notification
+def handle_notification(self, message):
+    print("Dice Notification: {0:08x}".format(message))
+if snd_unit.get_property('type') is 1:
+    snd_unit.connect('notified', handle_notification)
+    args = get_array()
+    args.append(0x0000030c)
+    try:
+        # The address of clock in Impact Twin
+        snd_unit.transact(0xffffe0000074, args, 0x00000020)
+    except Exception as e:
+        print(e)
+        sys.exit()
+
+# GUI
+class Sample(Gtk.Window):
+
+    def __init__(self):
+        Gtk.Window.__init__(self, title="Hinawa-1.0 gir sample")
+        self.set_border_width(20)
+
+        vbox = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=10)
+        self.add(vbox)
+
+        topbox = Gtk.Box(spacing=10)
+        vbox.pack_start(topbox, True, True, 0)
+
+        button = Gtk.Button("transact")
+        button.connect("clicked", self.on_click_transact)
+        topbox.pack_start(button, True, True, 0)
+
+        button = Gtk.Button("_Close", use_underline=True)
+        button.connect("clicked", self.on_click_close)
+        topbox.pack_start(button, True, True, 0)
+
+        bottombox = Gtk.Box(spacing=10)
+        vbox.pack_start(bottombox, True, True, 0)
+
+        self.entry = Gtk.Entry()
+        self.entry.set_text("0xfffff0000980")
+        bottombox.pack_start(self.entry, True, True, 0)
+
+        self.label = Gtk.Label("result")
+        self.label.set_text("0x00000000")
+        bottombox.pack_start(self.label, True, True, 0)
+
+    def on_click_transact(self, button):
+        try:
+            addr = int(self.entry.get_text(), 16)
+            val = snd_unit.read_transact(addr, 1)
+        except Exception as e:
+            print(e)
+            return
+
+        self.label.set_text('0x{0:08x}'.format(val[0]))
+        print(self.label.get_text())
+
+    def on_click_close(self, button):
+        print("Closing application")
+        Gtk.main_quit()
+
+# Main logic
+win = Sample()
+win.connect("delete-event", Gtk.main_quit)
+win.show_all()
+
+Gtk.main()
+
+sys.exit()
diff --git a/libhinawa/samples/qt4.py b/libhinawa/samples/qt4.py
new file mode 100755
index 0000000..43611a1
--- /dev/null
+++ b/libhinawa/samples/qt4.py
@@ -0,0 +1,206 @@
+#!/usr/bin/env python2
+
+import sys
+
+# PyQt4 is not released for python3, sigh...
+# The combination of Python2 and Qt4 has a disadvantage for QString.
+# This forces interpretor to handle QString as usual unicode string.
+import sip
+sip.setapi('QString', 2)
+from PyQt4.QtCore import Qt
+from PyQt4.QtGui import QApplication, QWidget, QHBoxLayout, QVBoxLayout
+from PyQt4.QtGui import QToolButton, QGroupBox, QLineEdit, QLabel
+
+# Hinawa-1.0 gir
+from gi.repository import Hinawa
+
+from array import array
+
+# helper function
+def get_array():
+    # The width with 'L' parameter is depending on environment.
+    arr = array('L')
+    if arr.itemsize is not 4:
+        arr = array('I')
+    return arr
+
+# query sound devices
+index = -1
+while True:
+    try:
+        index = Hinawa.UnitQuery.get_sibling(index)
+    except Exception as e:
+        break
+    break
+
+# no fw sound devices are detected.
+if index == -1:
+    print('No sound FireWire devices found.')
+    sys.exit()
+
+# get unit type
+try:
+    unit_type = Hinawa.UnitQuery.get_unit_type(index)
+except Exception as e:
+    print(e)
+    sys.exit()
+
+# create sound unit
+def handle_lock_status(snd_unit, status):
+    if status:
+        print("streaming is locked.");
+    else:
+        print("streaming is unlocked.");
+if unit_type == 1:
+    snd_unit = Hinawa.SndDice()
+elif unit_type == 2:
+    snd_unit = Hinawa.SndEfw()
+elif unit_type == 3 or unit_type == 4:
+    snd_unit = Hinawa.SndUnit()
+path = "hw:{0}".format(index)
+try:
+    snd_unit.open(path)
+except Exception as e:
+    print(e)
+    sys.exit()
+print('Sound device info:')
+print(' type:\t{0}'.format(snd_unit.get_property("type")))
+print(' card:\t{0}'.format(snd_unit.get_property("card")))
+print(' device:\t{0}'.format(snd_unit.get_property("device")))
+print(' GUID:\t{0:016x}'.format(snd_unit.get_property("guid")))
+snd_unit.connect("lock-status", handle_lock_status)
+
+# create FireWire unit
+def handle_bus_update(snd_unit):
+	print(snd_unit.get_property('generation'))
+snd_unit.connect("bus-update", handle_bus_update)
+
+# start listening
+try:
+    snd_unit.listen()
+except Exception as e:
+    print(e)
+    sys.exit()
+
+# create firewire responder
+resp = Hinawa.FwResp()
+def handle_request(resp, tcode, req_frame):
+    print('Requested with tcode {0}:'.format(tcode))
+    for i in range(len(req_frame)):
+        print(' [{0:02d}]: 0x{1:08x}'.format(i, req_frame[i]))
+    # Return no data for the response frame
+    return None
+try:
+    resp.register(snd_unit, 0xfffff0000d00, 0x100)
+    resp.connect('requested', handle_request)
+except Exception as e:
+    print(e)
+    sys.exit()
+
+# create firewire requester
+req = Hinawa.FwReq()
+
+# Fireworks/BeBoB/OXFW supports FCP and some AV/C commands
+if snd_unit.get_property('type') is not 1:
+    request = bytearray(8)
+    request[0] = 0x01
+    request[1] = 0xff
+    request[2] = 0x19
+    request[3] = 0x00
+    request[4] = 0xff
+    request[5] = 0xff
+    request[6] = 0xff
+    request[7] = 0xff
+
+    try:
+        response = snd_unit.fcp_transact(request)
+    except Exception as e:
+        print(e)
+        sys.exit()
+    print('FCP Response:')
+    for i in range(len(response)):
+        print(' [{0:02d}]: 0x{1:02x}'.format(i, ord(response[i])))
+
+# Echo Fireworks Transaction
+if snd_unit.get_property("type") is 2:
+    args = get_array()
+    args.append(5)
+    try:
+        params = snd_unit.transact(6, 1, args)
+    except Exception as e:
+        print(e)
+        sys.exit()
+    print('Echo Fireworks Transaction Response:')
+    for i in range(len(params)):
+        print(" [{0:02d}]: {1:08x}".format(i, params[i]))
+
+# Dice notification
+def handle_notification(self, message):
+    print("Dice Notification: {0:08x}".format(message))
+if snd_unit.get_property('type') is 1:
+    snd_unit.connect('notified', handle_notification)
+    args = get_array()
+    args.append(0x0000030c)
+    try:
+        # The address of clock in Impact Twin
+        snd_unit.transact(0xffffe0000074, args, 0x00000020)
+    except Exception as e:
+        print(e)
+        sys.exit()
+
+# GUI
+class Sample(QWidget):
+    def __init__(self, parent=None):
+        super(Sample, self).__init__(parent)
+
+        self.setWindowTitle("Hinawa-1.0 gir sample with PyQt4")
+
+        layout = QVBoxLayout()
+        self.setLayout(layout)
+
+        top_grp = QGroupBox(self)
+        top_layout = QHBoxLayout()
+        top_grp.setLayout(top_layout)
+        layout.addWidget(top_grp)
+
+        buttom_grp = QGroupBox(self)
+        buttom_layout = QHBoxLayout()
+        buttom_grp.setLayout(buttom_layout)
+        layout.addWidget(buttom_grp)
+
+        button = QToolButton(top_grp)
+        button.setText('transact')
+        top_layout.addWidget(button)
+        button.clicked.connect(self.transact)
+
+        close = QToolButton(top_grp)
+        close.setText('close')
+        top_layout.addWidget(close)
+        close.clicked.connect(app.quit)
+
+        self.addr = QLineEdit(buttom_grp)
+        self.addr.setText('0xfffff0000980')
+        buttom_layout.addWidget(self.addr)
+
+        self.value = QLabel(buttom_grp)
+        self.value.setText('00000000')
+        buttom_layout.addWidget(self.value)
+
+    def transact(self, val):
+        try:
+            addr = int(self.addr.text(), 16)
+            val = req.read(snd_unit, addr, 1)
+        except Exception as e:
+            print(e)
+            return
+
+        self.value.setText('0x{0:08x}'.format(val[0]))
+        print(self.value.text())
+
+app = QApplication(sys.argv)
+sample = Sample()
+
+sample.show()
+app.exec_()
+
+sys.exit()
diff --git a/libhinawa/samples/qt5.py b/libhinawa/samples/qt5.py
new file mode 100755
index 0000000..ffe528b
--- /dev/null
+++ b/libhinawa/samples/qt5.py
@@ -0,0 +1,192 @@
+#!/usr/bin/env python3
+
+import sys
+
+# Qt5 python binding
+from PyQt5.QtWidgets import QApplication, QWidget, QHBoxLayout, QVBoxLayout
+from PyQt5.QtWidgets import QToolButton, QGroupBox, QLineEdit, QLabel
+
+# Hinawa-1.0 gir
+from gi.repository import Hinawa
+
+from array import array
+
+# helper function
+def get_array():
+    # The width with 'L' parameter is depending on environment.
+    arr = array('L')
+    if arr.itemsize is not 4:
+        arr = array('I')
+    return arr
+
+# query sound devices
+index = -1
+while True:
+    try:
+        index = Hinawa.UnitQuery.get_sibling(index)
+    except Exception as e:
+        break
+    break
+
+# no fw sound devices are detected.
+if index == -1:
+    print('No sound FireWire devices found.')
+    sys.exit()
+
+# get unit type
+try:
+    unit_type = Hinawa.UnitQuery.get_unit_type(index)
+except Exception as e:
+    print(e)
+    sys.exit()
+
+# create sound unit
+def handle_lock_status(snd_unit, status):
+    if status:
+        print("streaming is locked.");
+    else:
+        print("streaming is unlocked.");
+if unit_type == 1:
+    snd_unit = Hinawa.SndDice()
+elif unit_type == 2:
+    snd_unit = Hinawa.SndEfw()
+elif unit_type == 3 or unit_type == 4:
+    snd_unit = Hinawa.SndUnit()
+path = "hw:{0}".format(index)
+try:
+    snd_unit.open(path)
+except Exception as e:
+    print(e)
+    sys.exit()
+print('Sound device info:')
+print(' type:\t{0}'.format(snd_unit.get_property("type")))
+print(' card:\t{0}'.format(snd_unit.get_property("card")))
+print(' device:\t{0}'.format(snd_unit.get_property("device")))
+print(' GUID:\t{0:016x}'.format(snd_unit.get_property("guid")))
+snd_unit.connect("lock-status", handle_lock_status)
+
+# create FireWire unit
+def handle_bus_update(snd_unit):
+	print(snd_unit.get_property('generation'))
+snd_unit.connect("bus-update", handle_bus_update)
+
+# start listening
+try:
+    snd_unit.listen()
+except Exception as e:
+    print(e)
+    sys.exit()
+
+# create firewire responder
+resp = Hinawa.FwResp()
+def handle_request(resp, tcode, req_frame):
+    print('Requested with tcode {0}:'.format(tcode))
+    for i in range(len(req_frame)):
+        print(' [{0:02d}]: 0x{1:08x}'.format(i, req_frame[i]))
+    # Return no data for the response frame
+    return None
+try:
+    resp.register(snd_unit, 0xfffff0000d00, 0x100)
+    resp.connect('requested', handle_request)
+except Exception as e:
+    print(e)
+    sys.exit()
+
+# create firewire requester
+req = Hinawa.FwReq()
+
+# Fireworks/BeBoB/OXFW supports FCP and some AV/C commands
+if snd_unit.get_property('type') is not 1:
+    request = bytes([0x01, 0xff, 0x19, 0x00, 0xff, 0xff, 0xff, 0xff])
+    try:
+        response = snd_unit.fcp_transact(request)
+    except Exception as e:
+        print(e)
+        sys.exit()
+    print('FCP Response:')
+    for i in range(len(response)):
+        print(' [{0:02d}]: 0x{1:02x}'.format(i, response[i]))
+
+# Echo Fireworks Transaction
+if snd_unit.get_property("type") is 2:
+    args = get_array()
+    args.append(5)
+    try:
+        params = snd_unit.transact(6, 1, args)
+    except Exception as e:
+        print(e)
+        sys.exit()
+    print('Echo Fireworks Transaction Response:')
+    for i in range(len(params)):
+        print(" [{0:02d}]: {1:08x}".format(i, params[i]))
+
+# Dice notification
+def handle_notification(self, message):
+    print("Dice Notification: {0:08x}".format(message))
+if snd_unit.get_property('type') is 1:
+    snd_unit.connect('notified', handle_notification)
+    args = get_array()
+    args.append(0x0000030c)
+    try:
+        # The address of clock in Impact Twin
+        snd_unit.transact(0xffffe0000074, args, 0x00000020)
+    except Exception as e:
+        print(e)
+        sys.exit()
+
+# GUI
+class Sample(QWidget):
+    def __init__(self, parent=None):
+        super(Sample, self).__init__(parent)
+
+        self.setWindowTitle("Hinawa-1.0 gir sample with PyQt5")
+
+        layout = QVBoxLayout()
+        self.setLayout(layout)
+
+        top_grp = QGroupBox(self)
+        top_layout = QHBoxLayout()
+        top_grp.setLayout(top_layout)
+        layout.addWidget(top_grp)
+
+        buttom_grp = QGroupBox(self)
+        buttom_layout = QHBoxLayout()
+        buttom_grp.setLayout(buttom_layout)
+        layout.addWidget(buttom_grp)
+
+        button = QToolButton(top_grp)
+        button.setText('transact')
+        top_layout.addWidget(button)
+        button.clicked.connect(self.transact)
+
+        close = QToolButton(top_grp)
+        close.setText('close')
+        top_layout.addWidget(close)
+        close.clicked.connect(app.quit)
+
+        self.addr = QLineEdit(buttom_grp)
+        self.addr.setText('0xfffff0000980')
+        buttom_layout.addWidget(self.addr)
+
+        self.value = QLabel(buttom_grp)
+        self.value.setText('00000000')
+        buttom_layout.addWidget(self.value)
+
+    def transact(self, val):
+        try:
+            addr = int(self.addr.text(), 16)
+            val = req.read(snd_unit, addr, 1)
+        except Exception as e:
+            print(e)
+            return
+
+        self.value.setText('0x{0:08x}'.format(val[0]))
+        print(self.value.text())
+
+app = QApplication(sys.argv)
+sample = Sample()
+
+sample.show()
+app.exec()
+
+sys.exit()
diff --git a/libhinawa/samples/run.sh b/libhinawa/samples/run.sh
new file mode 100755
index 0000000..8db3abc
--- /dev/null
+++ b/libhinawa/samples/run.sh
@@ -0,0 +1,15 @@
+#!/bin/bash
+
+# NOTE:
+# Current working directory should be in root of this repository.
+
+export LD_LIBRARY_PATH=src/.libs/:/usr/lib:/lib
+export GI_TYPELIB_PATH=src/:/usr/lib/girepository-1.0
+
+if [[ $1 == 'qt4' ]] ; then
+	./samples/qt4.py
+elif [[ $1 == 'qt5' ]] ; then
+	./samples/qt5.py
+elif [[ $1 == 'gtk' ]] ; then
+	./samples/gtk3.py
+fi
-- 
2.1.0


------------------------------------------------------------------------------
New Year. New Location. New Benefits. New Data Center in Ashburn, VA.
GigeNET is offering a free month of service with a new server in Ashburn.
Choose from 2 high performing configs, both with 100TB of bandwidth.
Higher redundancy.Lower latency.Increased capacity.Completely compliant.
http://p.sf.net/sfu/gigenet
