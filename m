From: Mario Loritz <loritz@fh-furtwangen.de>
Subject: Re: config bug with sbawe and --with-isapnp=no
Date: Fri, 23 Jan 2004 11:13:34 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200401231113.35085.loritz@fh-furtwangen.de>
References: <200401221249.07577.loritz@fh-furtwangen.de>
Reply-To: loritz@fh-furtwangen.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200401221249.07577.loritz@fh-furtwangen.de>
Content-Disposition: inline
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

Hello list,

I reproduced the error message while the driver is loading:

# rcalsasound restart

Shutting down sound driver:                                          done
Starting sound driver: snd-sbawe /lib/modules/2.4.21-166-default/kernel/sound/
isa/sb/snd-sbawe.o: unresolved symbol pnp_activate_dev_R9e329e8c
/lib/modules/2.4.21-166-default/kernel/sound/isa/sb/snd-sbawe.o: unresolved 
symbol pnp_register_card_driver_R14e159bf
/lib/modules/2.4.21-166-default/kernel/sound/isa/sb/snd-sbawe.o: unresolved 
symbol pnp_manual_config_dev_R480f17aa
/lib/modules/2.4.21-166-default/kernel/sound/isa/sb/snd-sbawe.o: unresolved 
symbol pnp_release_card_device_R0d53db9b
/lib/modules/2.4.21-166-default/kernel/sound/isa/sb/snd-sbawe.o: unresolved 
symbol pnp_init_resource_table_R16084899
/lib/modules/2.4.21-166-default/kernel/sound/isa/sb/snd-sbawe.o: unresolved 
symbol pnp_unregister_card_driver_R82704514
/lib/modules/2.4.21-166-default/kernel/sound/isa/sb/snd-sbawe.o: unresolved 
symbol pnp_request_card_device_Rc3534026
/lib/modules/2.4.21-166-default/kernel/sound/isa/sb/snd-sbawe.o: insmod /lib/
modules/2.4.21-166-default/kernel/sound/isa/sb/snd-sbawe.o failed
/lib/modules/2.4.21-166-default/kernel/sound/isa/sb/snd-sbawe.o: insmod 
snd-sbawe failed
                                                                     done
Starting sound driver: snd-ice1712                                   done

What is strange is that the drivers try to use symbols like "pnp_activate"
that they dont need and dont use, as the drivers were compiled WITHOUT
pnp support.

Thanks for the answers so far!
Mario 



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
