From: R Chan <rspchan@starhub.net.sg>
Subject: Some proposed ALSA sysfs changes to stock kernel from GregKH
Date: Tue, 20 Jan 2004 11:12:33 +0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <400C9CA1.6030706@starhub.net.sg>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Greg KH is proposing some sysfs changes to the stock kernel - any impact on
CVS ALSA? Is it ok to rely solely on CVS ALSA -  I always build 2.6 from 
the stock
tree and then immediately overwrite the sound directory with ALSA CVS.


*List:       linux-kernel <http://marc.theaimsgroup.com/?l=linux-kernel&r=1&w=2>
Subject:    Re: [PATCH] Driver Core update and fixes for 2.6.1 <http://marc.theaimsgroup.com/?t=107456216600001&r=1&w=2>
From:       Greg KH <greg () kroah ! com> <http://marc.theaimsgroup.com/?a=93270967100001&r=1&w=2>
Date:       2004-01-20 1:12:41 <http://marc.theaimsgroup.com/?l=linux-kernel&r=1&w=2&b=200401>
Message-ID: <1074561161776 () kroah ! com> <http://marc.theaimsgroup.com/?i=%3C1074561161776%20%28%29%20kroah%20%21%20com%3E>
[Download message RAW <http://marc.theaimsgroup.com/?l=linux-kernel&m=107456203421173&q=raw>]*

ChangeSet 1.1504, 2004/01/19 16:45:49-08:00, greg@kroah.com

[PATCH] ALSA: add sysfs class support for ALSA sound devices

This patch adds support for all ALSA sound devices.  The previous OSS
sound patch is required for this one to work properly.

This patch is based on a work originally written by
Leann Ogasawara <ogasawara@osdl.org>


 include/sound/core.h |    1 +
 sound/core/sound.c   |   34 ++++++++++++++++++++--------------
 sound/pci/intel8x0.c |    1 +


The OSS patch he is referring to is


 include/sound/core.h |    1 +
 sound/core/sound.c   |   34 ++++++++++++++++++++--------------
 sound/pci/intel8x0.c |    1 +
 3 files changed, 22 insertions(+), 14 deletions(-)
 3 files changed, 22 insertions(+), 14 deletions(-)



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
