From: Lorn Potter <lpotter@trolltech.com>
Subject: Re: Moving from OSS to ALSA
Date: Mon, 12 Jan 2004 08:29:54 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200401120829.54299.lpotter@trolltech.com>
References: <20040111181311.7726a5b5.james@jigsawdezign.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040111181311.7726a5b5.james@jigsawdezign.com>
Content-Disposition: inline
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

On Monday 12 January 2004 4:13 am, James Wright wrote:
>  I am currently looking into rewriting our current OSS sound routines to
> native ALSA, as it seems OSS will invariably be phased out now that the
> ALSA driver is distrubuted with the Linux kernel, plus ALSA seems to have a
> great number of benefits for us.

Personally, I hope OSS compat will never be phased out. Why? OSS is simple, 
and concise. If I am writing a simple audio recording/playing app, I can get 
the job done using OSS code in _much_ less lines of code.


_Dont get me wrong_, ALSA is great and a lot more powerful than OSS, but it is 
lacking a simple API. 
Ever try to write an In/Out volume control mixer in OSS? Ever try to port that 
same mixer to ALSA?  From what I can gather (alsa seems to be lacking mixer 
docs/tutorial) , the only way to change the mic input level (alsa), I have to 
enumerate over every mixer gizmo and check to see if its the mic, and then 
change it if I think it appears to be the Mic.

Using OSS, I can do that in one line.






-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
