From: Peter Heatwole <peter599@gotnet.net>
Subject: Cirrus Logic S/PDIF
Date: Fri, 17 May 2002 08:24:15 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020517152415.GA872@porky>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hello,

    I have a CS4281 based card with a CS4297A AC'97 codec, and wanted
to use the IEC958 jack. After reading some of the specs, I realized
that the function "patch_cirrus_cs4205()" in ac97_codec.c applies to
the CS4297A codec as well. I changed the line in the snd_ac97_codec_ids
array that corresponds to the CS4297A, and made it use the CS4205 patch,
and the codec successfully copies the data to the iec958 jack as well
as analog out.
    What would be the drawbacks to setting this line in the CVS? I realize
this will not work for all soundcards using the CS4297A (for instance, I
used this patch with my Santa Cruz (CS4630 DSP), with no luck, as 
expected),
but would using the patch cause harm?
    I have not checked, but I assume this would also apply to other Cirrus
Logic AC'97 codecs?

(Any additional info/corrections you may send me via personal mail would
also be much appreciated.)


-- Peter Heatwole
"Murphy was just a well known pessimist."

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
