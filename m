From: Mark Knecht <markknecht@attbi.com>
Subject: Re: hdsp patch
Date: 15 Jun 2003 20:49:00 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1055735340.2742.77.camel@Wizard.knechthome.com>
References: <1055734773.2742.68.camel@Wizard.knechthome.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1055734773.2742.68.camel@Wizard.knechthome.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 2003-06-15 at 20:42, Paul Davis wrote:
> >I have alsamixer up and running, and the volumes turned down to 6 and
> >it's still screaming loud. Is this like the old driver where the mixer
> >didn't work at all? Or have I not set the right things?
> 
> no, the mixer "works", but unfortunately it appears that i didn't test
> enough. the code still appears to be not quite right - there's a
> tricky detail that you can only write 32 bit values to the mixer, but
> each mixer element is 16 bits, so you always have to write the one you
> want to modify, plus its "neighbour". looks like i don't have that
> quite right yet.

OK, well I'll stay tuned for possible patches and testing whatever you
need. Thanks.

If it makes any difference in simplifying your initial testing, I have
my speakers hooked to the HDSP9652 ADAT1 port, using channels 1 & 2. I'm
not using any other channels in that group, or any other ADAT outputs as
of yet. 

If you think some other outputs do work (in terms of modifying the
volumes, let me know and I'll switch to them.

I don't suppose there is any .asoundrc magic that could reduce the
volume automagically in Alsa itself instead of in the driver? (A JAck
volume control?) ;-)

> 
> >The other thing I notice is I only seem to be able to set 24 values in
> >my little script to set volumes. The driver I just replaced allowed me
> >to set all 26.
> 
> i'll check on that. probably just a mistake on my part about the
> number of channels (i tend to forget the s/pdif outs).

I figured as much. No problem right now.

> 
> >Also, please answer - do I need to set routing paths through the HDSP
> >FPGA to get the mixer working?
> 
> no. the mixer is (dis|en)abled by flipping a control register bit. if
> its on, its on. what needs work is the hdsp_write_gain() function.
> 
> --p

OK, I was just remembering Roger Williams telling my some stuff back in
January when I was first trying to get this working (when we didn't know
that the volume controls didn't work) about needing to break
connections. He sent a little script file for the Digiface, but I was
not sure if this was required, or just something he kept around for test
purposes:

#!/bin/bash

ADAT1="0 1 2 3 4 5 6 7"
ADAT2="8 9 10 11 12 13 14 15"
ADAT3="16 17 18 19 20 21 22 23"
SPDIF="24 25"

function disconnect () {
    for output in "$@"; do
        input=0
        while [ $input -le 25 ]; do
            echo -n "."
            amixer cset numid=5 $input,$output,0 > /dev/null
            input=$((input+1))
        done
    done
    echo
}

echo -n "Disconnecting ADAT1 outputs"
disconnect $ADAT1
echo -n "Disconnecting ADAT2 outputs"
disconnect $ADAT2
echo -n "Disconnecting ADAT3 outputs"
disconnect $ADAT3
echo -n "Disconnecting SPDIF output"
disconnect $SPDIF

Thanks,
Mark



-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
