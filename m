From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: what does alsaconf do?
Date: Sun, 29 Jan 2006 12:51:25 +0000
Message-ID: <1138539085.9221.2.camel@localhost.localdomain>
References: <1138456724.9726.13.camel@localhost.localdomain>
	 <20060129114023.GA16314@palantir8>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sc-outsmtp1.homechoice.co.uk (sc-outsmtp1.homechoice.co.uk [81.1.65.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 64059187
	for <alsa-devel@alsa-project.org>; Sun, 29 Jan 2006 13:51:36 +0100 (MET)
In-Reply-To: <20060129114023.GA16314@palantir8>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Martin Habets <errandir_news@mph.eclipse.co.uk>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, 2006-01-29 at 11:40 +0000, Martin Habets wrote:
> On Sat, Jan 28, 2006 at 01:58:44PM +0000, Adrian McMenamin wrote:

> 
> If your hardware does not vary an alternative is to avoid alsaconf and
> hardcode the entries in /etc/modules.conf (or whatever you use).
> It would be quite substantial to rewrite alsaconf for your setup.
> If you really need such a tool maybe it would be better to write a
> ucalsaconf. Hard to say really, as I have no clue about the actual
> hardware you have.
> 

Well, it is a Dreamcast (SH4, 16 MB RAM, nfsroot for filesystem though
Ramdisk is also usable)

To be honest I just want to concentrate on the driver. But aplay, which
I planned to use for a test, appears to fail without an alsa.conf so I
am a bit stuck.

When you say hardcode the entries in modules.conf do you mean alsaconf
just specifies which modules to load?



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
