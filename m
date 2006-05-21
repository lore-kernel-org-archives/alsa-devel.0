From: Eliot Blennerhassett <linux@blennerhassett.gen.nz>
Subject: Re: What if 4 PCM-instances are not enough?
Date: Mon, 22 May 2006 11:00:30 +1200
Message-ID: <200605221100.31956.linux@blennerhassett.gen.nz>
References: <4470C514.2080705@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4470C514.2080705@gmx.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
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

On Mon, 22 May 2006 07:52, Henrik Kretzschmar wrote:
> Hi,
>
> we are developing a ALSA-device driver for the SEK'D/Marian ARC88,
> which has 4 analog stereo IO's and a digital IO.
> So there's is that little problem, that there only could be two
> combinations: 4 analog IO/0 digital
> 3 analog IO/1 digital,
> which should IMHO be taken under attack in the future.
>
> I am reading LDD3 at the moment and wondered how the best use of the 2.6
> dev_t, which doesn't limit the minors to 255, the starting point for my
> problem.
>
> Is there a solution insight, which doesn't break compatibility with older
> apps?

One possibility is to use subdevices for each stereo I/O.
PCM0 with 4 analog subdevices
PCM1 with 1 digital subdevice.

--
Eliot
AudioScience Inc.


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
