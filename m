From: Martin Langer <martin-langer@gmx.de>
Subject: Re: Compiler detection fails
Date: Sun, 1 Jun 2003 19:25:59 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030601172559.GA1604@tuba.home>
References: <Pine.HPX.4.33n.0306011224400.940-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.HPX.4.33n.0306011224400.940-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, Jun 01, 2003 at 12:27:11PM +0200, Clemens Ladisch wrote:
> 
> on Slackware 8.0:
> 
> $ gcc --version
> 2.95.3
> $ ./configure
> ...
> checking for GCC version... Kernel compiler: gcc 2.95.3 20010315 (release) Used compiler: 2.95.3
> Fatal error: Compiler type does not match
> Decoded kernel compiler: type=gcc version=2.95.3
> Decoded used compiler: type=2.95.3 version=2.95.3
> 

same on debian gcc:

[...]
checking for GCC version... Kernel compiler: gcc 2.95.4 20011002 (Debian
prerelease) Used compiler: 2.95.4
Fatal error: Compiler type does not match
Decoded kernel compiler: type=gcc version=2.95.4
Decoded used compiler: type=2.95.4 version=2.95.4
[...]


martin


-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
