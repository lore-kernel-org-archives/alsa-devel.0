From: "Sebastian H." <vand2@gmx.de>
Subject: QasTools 0.17.0 released
Date: Tue, 17 Jan 2012 16:28:05 +0100
Message-ID: <4F159385.2080809@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout-de.gmx.net (mailout-de.gmx.net [213.165.64.23])
	by alsa0.perex.cz (Postfix) with SMTP id 49305103A10
	for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2012 16:30:12 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-user@lists.sourceforge.net
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

QasTools version 0.17.0 is available.

QasTools is a collection of dektop applications for ALSA.

Changes:

 * all: setting names for state save/restore changed/regrouped
 * all: smart main window sizeHint() to get a useable window
        size after leaving fullscreen
 * all: new common info dialog - uses QListView page
        selection intead of tabs
 * shared: device selection style tweaks: selected item
           now emphasized by a thin frame
 * shared: device selection style tweaks: Rounded selection area
 * shared: use QSplitter instead of QDockwidget for device selection
           view. It couldn't be detached anyway and size restoring
           works more reliable.
 * qasconfig: settings directory changed to shared ~/.config/qastools/
              (was ~/.config/qasconfig/)
 * qasconfig: new basic command line options (--version, --help, etc.)
 * qashctl: new basic command line options (--version, --help, etc.)
 * qasmixer: new application icon


Homepage with more information
http://xwmw.org/qastools

Project page
http://sourceforge.net/projects/qastools/


Happy volume changing!

-- Sebastian Holtermann
