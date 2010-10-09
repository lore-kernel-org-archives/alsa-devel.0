From: "Sebastian H." <vand2@gmx.de>
Subject: Alsamixer-Qt4 0.5.0 released
Date: Sat, 09 Oct 2010 22:41:04 +0200
Message-ID: <4CB0D360.2010201@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mailout-de.gmx.net [213.165.64.22])
	by alsa0.perex.cz (Postfix) with SMTP id 091112432C
	for <alsa-devel@alsa-project.org>;
	Sat,  9 Oct 2010 22:43:10 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-user@lists.sourceforge.net" <alsa-user@lists.sourceforge.net>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello again

After an almost complete rewrite to support separate channels views
in the main sliders and switches areas, Alsamixer-Qt4 0.5.0 is now
available.

http://xwmw.org/alsamixer-qt4/
http://sourceforge.net/projects/alsamixer-qt4/files/


This is a snapshot from the CHANGELOG file.

* The channels mixer dialog is gone
* Mixer elements can be toggled between joined and channels view
* Automated switch from joined to channels view if channels values
  differ for a certain time
* New context menus for mixer elements
* New dynamic support for the Alsa is_active element flag
* New command line arguments similar to the console alsamixer ones
* The card selection widget got basic support for Alsa plugins
* GUI cleanups and slight style changes
* Reduced CPU usage by showing QSpinBox widgets only on demand
  (mouse over)
* Fixed a forgotten debug timer that was always running
  in 0.4.1 (constant 1% CPU usage)


I ran several tests but since a lot of code has been rewritten
there still may be regressions or even new bugs.
There're also some implemented features I couldn't test at all
because my rather basic hardware doesn't support it.

- Mixer elements with more than two channels.
If the sliders arrangement or some graphics for your card
with 32 channels per element look weird, please drop me a
note and/or a screenshot.

- Is-active flag
In theory the mixer should support dynamic hiding and
revealing of elements whose is-active flag changes.
If it doesn't or even crashes, please tell.


Any comments are welcome.


Best,
Sebastian H.
