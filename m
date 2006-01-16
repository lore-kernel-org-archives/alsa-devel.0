From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: How are multiple capture sources confusing
	alsamixer?
Date: Sun, 15 Jan 2006 20:32:40 -0500
Message-ID: <1137375161.25801.127.camel@mindpipe>
References: <200601160121.k0G1LrSU013170@auster.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200601160121.k0G1LrSU013170@auster.physics.adelaide.edu.au>
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

On Mon, 2006-01-16 at 11:51 +1030, Jonathan Woithe wrote:
> Hi all
> 
> I've noticed the following comment in a variety of drivers:
> 
>   /* The multiple "Capture Source" controls confuse alsamixer
>    * So call somewhat different..
>    * FIXME: the controls appear in the "playback" view!
>    */
>   /* .name = "Capture Source", */
> 
> I've been working on adding the second capture source to the ALC260 Fujitsu
> configuration and have not really seen any major problems with alsamixer's
> interpretation when two capture sources are declared.  What seems to happen
> for me is that each potential source gets two capture switches; one switches
> to the first capture source and the other switches to the second capture
> source.  Furthermore, all this appears to work fine.
> 
> So, in what way(s) does the presence of multiple capture sources confuse
> alsamixer and give rise to the source-code comment quoted above?

I think the only issue is that alsamixer has a flat namespace for
controls so you can't have two mixer elements called "Capture Source" in
the same driver.  But, I could be wrong.

Lee



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
