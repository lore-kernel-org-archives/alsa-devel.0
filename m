From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Redhat packaging...
Date: Fri, 19 Aug 2005 23:09:05 -0400
Message-ID: <1124507345.25916.30.camel@mindpipe>
References: <43068E57.8090900@redfish-solutions.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <43068E57.8090900@redfish-solutions.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Philip Prindeville <philipp_subx@redfish-solutions.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 2005-08-19 at 19:58 -0600, Philip Prindeville wrote:
> what do I need to tweak to have things go into the right places
> (i.e. with a command-line build, "make install LIBDIR=..." etc). 

This is a 64 bit FC3 system right?  Check the alsa-devel archives and
the bug tracker for 64 bit Fedora issues, at one point ALSA definitely
had a bug where it did not get the /lib64 or whatever path right.

Also, I think perex changed the build system quite a bit over the past
week.  Try reverting to 1.0.9b (cvs co -r1-0-9b) or go back a month and
do a binary search by date (cvs update -D2005-07-19).

Lee



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
