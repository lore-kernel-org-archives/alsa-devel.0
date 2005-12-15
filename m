From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH] Adds dB gain to alsa-driver, alsa-lib.
Date: Thu, 15 Dec 2005 13:58:22 -0500
Message-ID: <1134673103.12086.144.camel@mindpipe>
References: <43A1B744.2050703@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <43A1B744.2050703@superbug.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 2005-12-15 at 18:34 +0000, James Courtier-Dutton wrote:
> Hi,
> 
> I have implemented dB gain reporting for ALSA mixer controls.
> By applying the attached patches to alsa-driver and alsa-lib, one will 
> then see dB values appear in alsamixer. (I added support to alsamixer a 
> long time ago)
> 
> Currently, only the snd-ca0106 sound card reports the values.
> 
> If the method is agreed upon, I will extend it to many more sound cards.

Can you briefly explain the process for adding this feature to an
existing driver (IOW say you have no docs just a vendor-obfuscated or
RE'd driver, how do you determine db_scale)?

Lee



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
