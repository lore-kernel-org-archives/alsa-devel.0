From: Pannaga Bhushan <bhushan@multitech.co.in>
Subject: pls clarify.
Date: Fri, 18 Oct 2002 09:35:03 +0530
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DAF886E.72345086@multitech.co.in>
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
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi all,
         In the funtion - snd_pcm_hw_ptr_interrupt ,  there are the
following lines --

delta = hw_ptr_interrupt - new_hw_ptr;
if(delta > 0) {
    if( delta < runtime->buffer_size / 2) {
        snd_printd("Unexpected hw_pointer value .... wrong interrupt
acknowledge?\n"...);
        return 0;
    }
    runtime->hw_ptr_base += runtime->buffer_size;
    -------
    ------
    -------
}


Can you pls clarify what these lines are doing? what is the significance
of delta and the significance of delta > 0 but less than
runtime->buffer_size/2   being a case of wrong interrupt ack.

thanx in advance,
Pannaga Bhushan



-------------------------------------------------------
This sf.net email is sponsored by: viaVerio will pay you up to
$1,000 for every account that you consolidate with us.
http://ad.doubleclick.net/clk;4749864;7604308;v?
http://www.viaverio.com/consolidator/osdn.cfm
