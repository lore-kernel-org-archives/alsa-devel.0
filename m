From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Packages to build for userland
Date: Sat, 26 Nov 2005 16:18:15 +0000
Message-ID: <43888AC7.3060207@superbug.co.uk>
References: <1133020862.19648.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1133020862.19648.1.camel@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Adrian McMenamin wrote:
> Building an alsa driver for SH -- wondering which packages I need for a
> minimum userland to test my driver. What do the various packages do and
> what is the *absolute minimum* I need to test the system?
> 

You need the kernel modules, so alsa-driver.
You need alsa-lib (libasound), so alsa-lib
You probably want a basic mixer app, and probably a speaker-test app, so 
alsa-utils.

Summary:
alsa-driver, alsa-lib, alsa-utils.

James



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
