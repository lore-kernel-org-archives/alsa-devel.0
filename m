From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Moving from OSS to ALSA
Date: Sun, 11 Jan 2004 23:48:44 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <yw1xfzemrtir.fsf@kth.se>
References: <20040111181311.7726a5b5.james@jigsawdezign.com> <200401120829.54299.lpotter@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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

Lorn Potter <lpotter@trolltech.com> writes:

> On Monday 12 January 2004 4:13 am, James Wright wrote:
>>  I am currently looking into rewriting our current OSS sound routines to
>> native ALSA, as it seems OSS will invariably be phased out now that the
>> ALSA driver is distrubuted with the Linux kernel, plus ALSA seems to have a
>> great number of benefits for us.
>
> Personally, I hope OSS compat will never be phased out. Why? OSS is simple, 
> and concise. If I am writing a simple audio recording/playing app, I can get 
> the job done using OSS code in _much_ less lines of code.

I have to disagree.  For my music/video player, I've written both ALSA
and OSS output modules.  The ALSA module is 261 lines, the OSS module
258 lines, including comments and whitespace.  The ALSA module does
things that are more or less impossible with OSS, such as sample
accurate timing.

-- 
Måns Rullgård
mru@kth.se



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
