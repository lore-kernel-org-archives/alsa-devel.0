From: Marcus Andersson <054185595@telia.com>
Subject: Re: HDSP Line Out Volume Control?
Date: Wed, 20 Nov 2002 22:12:00 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DDBFAA0.7CB10A5C@telia.com>
References: <20021120151934.GA4999@dogsolitude.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: drclaw@dogsolitude.org
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

you must use the matrix mixer for this. There are no simple controls
defined for the line out. The matrix mixer can mix any combination of
input and playback streams to any of the outputs. This means there are
52x28 = 1456 control values to set.

I have not tested the matrix mixer myself, and right now I don't have my
soundcard at home. I can do some more tests tomorrow. My guess is that
the inputs are numbered 0-25, the playbacks 26-51. The line out signals
have number 26 and 27. If you want to send 50% of the first and second
playback channels to line out, you will have to set the matrix mixer
with something like:

26, 26, 32768
27, 27, 32768

It would be interesting to hear if it works. I have been thinking of
writing a GUI to cotrol the matrix mixer. Maybe someone else has the
same idea.

Marcus

drclaw@dogsolitude.org wrote:
> 
> Hi, I've got an HDSP (Multiface + Cardbus) and I can't figure out how to
> get output on the line out that isn't either 0% or 100%.  Basically, if
> I don't use the module option "line_outs_monitor=1" I can't hear
> anything, but if I do use it, the volume is cranked and distorted.
> Also, what exactly is the "matrix mixer"?  Is this related to the
> problem of this "matrix mixer" being so complex?
> 
> Thanks,
> 
> 784 - Michael C. Piantedosi - drclaw@dogsolitude.org
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:
> Battle your brains against the best in the Thawte Crypto
> Challenge. Be the first to crack the code - register now:
> http://www.gothawte.com/rd521.html
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel


-------------------------------------------------------
This sf.net email is sponsored by: 
Battle your brains against the best in the Thawte Crypto 
Challenge. Be the first to crack the code - register now: 
http://www.gothawte.com/rd521.html
