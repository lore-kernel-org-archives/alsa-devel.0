From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: Re: Recording problem
Date: Fri, 15 Sep 2006 12:01:01 +0100
Message-ID: <1158318061.22950.43.camel@localhost.localdomain>
References: <64cf23610609150319n190d4005sf78af65dc7159e5f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <64cf23610609150319n190d4005sf78af65dc7159e5f@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Vishwas P S <vishwas.ps@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 2006-09-15 at 15:50 +0530, Vishwas P S wrote:
> Hi group,
>  
> I have a noise problem whenever I record sound with arecord.
> The sound seems to be very loud and it often gets clipped .. looks
> like the signal gets overloaded and gets clipped often.\
> I've ensured that the Mic gain is kept at a minimum and still it
> happens.
> (For the same config OSS gives a very low volume)
>  
> What could be the problem. Pl help out

Your correct in that your input signal is being clipped because the gain
is too high. 

It's worth checking the audio path between your mic and ADC to make sure
that there an no other amplifiers increasing the input gain. Please note
that some ADC's can also increase gain.

It's also possible that your hardware has ALC/AGC (Automatic Level|Gain
control). This automatically changes the gain depending on the volume of
the input signal so that the volume captured is constant. This will also
cause clipping if the settings are too high.

Liam




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
