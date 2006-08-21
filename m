From: John Rigg <ad@sound-man.co.uk>
Subject: Re: Sample Rate Conversion Quality in ALSA
Date: Mon, 21 Aug 2006 21:15:06 +0100
Message-ID: <20060821201506.GA3729@localhost.localdomain>
References: <b5ee41f40608210316t562c803eye73701c75904627@mail.gmail.com>
	<44E9AAFA.2060400@superbug.co.uk>
	<b5ee41f40608210602q4c4ae45eo5be8392be7e96099@mail.gmail.com>
	<20060821150338.GA3360@localhost.localdomain>
	<b5ee41f40608211207o165b7e20qb40625ad17065d18@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <b5ee41f40608211207o165b7e20qb40625ad17065d18@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Marc Brooker <marcbrooker@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 21, 2006 at 09:07:31PM +0200, Marc Brooker wrote:
> On a related note, on an Athlon64 3200+ running Ubuntu Dapper for i386
> with backported alsa-libs 1.0.11 and alsa-plugins 1.0.11 (with
> samplerate plugin) cpu usage figures (while playing a VBR mp3 using
> gstreamer):
> standard ALSA linear: 2%
> samplerate: 6%
> samplerate_medium: 9%
> samplerate_best: 20%
> 
> From this it seems that samplerate_best is too costly, but samplerate
> and samplerate_medium would be usable on most modern hardware.

If you're running an i386 distro you're only using half of the
Athlon64's registers. It would be interesting to see if that
samplerate_best CPU load is reduced in 64-bit mode.

John

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
