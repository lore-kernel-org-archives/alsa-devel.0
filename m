From: Juan Linietsky <coding@reduz.com.ar>
Subject: Re: Urgent Help needed
Date: Wed, 22 May 2002 14:41:46 -0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020522144146.253af5c9.coding@reduz.com.ar>
References: <E04CF3F88ACBD5119EFE00508BBB212102C91CDC@exch-01.noida.hcltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E04CF3F88ACBD5119EFE00508BBB212102C91CDC@exch-01.noida.hcltech.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 22 May 2002 20:35:09 +0530
"Shakul  Arora, Noida" <shakula@noida.hcltech.com> wrote:

> Hi,
> 
> Please if you can help how can I program the device the "MIX" mode
> for both LINE IN and MIC capture. I accept that both the 
> inputs are to be capture in mono, in stero mode the quality will be
> bad.

Check either alsamixer or any other ALSA or OSS compatible mixer. on
the same global volume send sliders you should be able to also set the
record option. You should also play with the IGAIN slider to adjust
the input volume rate for recording. One of the things that surprised
me the most about the ensoniq 1371 cards is the amazingly clean ADC
compared to my other cards. If you have your computer and whathaver
you are using as input source well connected and properly grounded,
you should get no noise at all while recording. So far i've been using
it as cheap analog source recording, connected to a mixer, which has
connected a couple of synths, and the results were extremely good.


Regards


Juan Linietsky



_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
