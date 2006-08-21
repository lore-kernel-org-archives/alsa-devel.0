From: John Rigg <ad@sound-man.co.uk>
Subject: Re: Sample Rate Conversion Quality in ALSA
Date: Mon, 21 Aug 2006 16:03:38 +0100
Message-ID: <20060821150338.GA3360@localhost.localdomain>
References: <b5ee41f40608210316t562c803eye73701c75904627@mail.gmail.com>
	<44E9AAFA.2060400@superbug.co.uk>
	<b5ee41f40608210602q4c4ae45eo5be8392be7e96099@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <b5ee41f40608210602q4c4ae45eo5be8392be7e96099@mail.gmail.com>
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

On Mon, Aug 21, 2006 at 03:02:07PM +0200, Marc Brooker wrote:
> Let me see if I understand you correctly. In the scenario that you
> presented the application is told that there are 940 samples per
> period. ALSA, internally, converts these to 1024 samples per period at
> 48kHz sample rate. So the material (sampled at 44100Hz) is played back
> at a rate of 44062Hz? I don't know enough about the field to know if
> this error (0.08%) will be audible.

To put that in perspective, a semitone is around 6% change in pitch.
The error here looks small at 0.08% but it's enough to make a musical
note sound out of tune.

John

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
