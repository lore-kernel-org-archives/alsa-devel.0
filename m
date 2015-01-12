From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC] libhinawa: gobject introspection library for
 ALSA/FireWire transaction
Date: Mon, 12 Jan 2015 23:52:55 +0900
Message-ID: <54B3DFC7.7010903@sakamocchi.jp>
References: <54215BF6.5090600@sakamocchi.jp>
 <20140930014919.GE5605@marvin.atrad.com.au> <542A13A4.8080607@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id A89282605A6
 for <alsa-devel@alsa-project.org>; Mon, 12 Jan 2015 15:53:00 +0100 (CET)
In-Reply-To: <542A13A4.8080607@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jonathan Woithe <jwoithe@just42.net>, Clemens Ladisch <clemens@ladisch.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "ffado-devel@lists.sf.net" <ffado-devel@lists.sf.net>
List-Id: alsa-devel@alsa-project.org

Hi,

I re-write this library with libglib-2.0/libgobject-2.0. Currently it
can be parsed by gobject introspection scanner and be available by
gobject instrospection binding. In this time, I added python scripts as
a test of combination between libhinawa and any GUI such as Gtk+, Qt.

https://github.com/takaswie/libhinawa

I'm happy to receive your comments.

== Background
The most of FireWire sound devices require software implementation to
control the device's functionality, such as 'matrix mixer' (See 3.2
Signal processing for internal mixing in
https://github.com/takaswie/alsa-firewire-report). Currently FFADO
project releases ffado-dbus-server/ffado-mixer for this role.

ALSA in Linux 3.16 or later support some FireWire sound devices newly,
approximately 100 models or more. ALSA drivers give some functionality
which FFADO doesn't support, such as Echo Fireworks Transaction and Dice
Notification.

The aim of this library is to give a way to use these functionality.
Furthermore, this library also supports read/write/lock transactions via
Linux FireWire subsystem to help programmers.

== Language bindings via gobject introspection
GObject introspection is a middleware layer between C libraries (using
GObject) and language bindings. In short, libhinawa can be available by
any languages which has gobject introspection support.
https://wiki.gnome.org/action/show/Projects/GObjectIntrospection

I re-designed libhinawa to use this mechanism. It becomes to depend
libglib-2.0 and libgobject-2.0 additionally. It means to become a bit
heavy to load these large library.

This library is still under development. API or object structure may be
changed when they're required.


Regards

Takashi Sakamoto
