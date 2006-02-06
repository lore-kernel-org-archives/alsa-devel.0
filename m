From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH] hda: ALC260 test model implementation
Date: Mon, 06 Feb 2006 18:02:22 -0500
Message-ID: <1139266943.2041.4.camel@mindpipe>
References: <200602062250.k16Mo0XK012879@auster.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200602062250.k16Mo0XK012879@auster.physics.adelaide.edu.au>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-02-07 at 09:20 +1030, Jonathan Woithe wrote:
> The following patch adds a "test" ALC260 model specification to the
> patch_realtek.c driver if CONFIG_SND_DEBUG is set.  This is similar to
> the "test" ALC880 model in that it sets up mixer controls for almost
> everything to make it easier for people to test their laptop/soundcard
> when working out what pin widgets are connected to which real-world
> devices.
> 

Man, these Intel HDA codecs are becoming a huge PITA... is there any end
in sight, or will users have to resort to trial and error every time any
vendor releases a new laptop?  This is starting to feel like the ACPI
situation... hmm, Intel designed that too, coincidence?

;-)

Lee



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
