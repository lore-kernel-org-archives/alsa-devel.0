From: kbuild test robot <fengguang.wu@intel.com>
Subject: [sound:topic/cht-whiskey-cove 1/3]
 include/acpi/acpi_bus.h:598:9: error: 'AE_SUPPORT' undeclared
Date: Wed, 1 Mar 2017 16:13:17 +0800
Message-ID: <201703011612.7NQlCSTp%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="azLHFNyN32YCQGCU"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 44BEE266860
 for <alsa-devel@alsa-project.org>; Wed,  1 Mar 2017 09:13:59 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git topic/cht-whiskey-cove
head:   fe0334695c856dbdbeea861a5eb76f5ddc0dbaa9
commit: fbba8603f93e60c68116197326cdbbceee0b875b [1/3] mfd: Add Cherrytrail WhiskeyCove PMIC driver
config: x86_64-randconfig-r0-03011404 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout fbba8603f93e60c68116197326cdbbceee0b875b
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

    acpi_status acpi_evaluate_ej0(acpi_handle handle);
                                  ^~~~~~~~~~~
   include/acpi/acpi_bus.h:59:1: error: unknown type name 'acpi_status'
    acpi_status acpi_evaluate_lck(acpi_handle handle, int lock);
    ^~~~~~~~~~~
   include/acpi/acpi_bus.h:59:31: error: unknown type name 'acpi_handle'
    acpi_status acpi_evaluate_lck(acpi_handle handle, int lock);
                                  ^~~~~~~~~~~
   include/acpi/acpi_bus.h:60:21: error: unknown type name 'acpi_handle'
    bool acpi_ata_match(acpi_handle handle);
                        ^~~~~~~~~~~
   include/acpi/acpi_bus.h:61:21: error: unknown type name 'acpi_handle'
    bool acpi_bay_match(acpi_handle handle);
                        ^~~~~~~~~~~
   include/acpi/acpi_bus.h:62:22: error: unknown type name 'acpi_handle'
    bool acpi_dock_match(acpi_handle handle);
                         ^~~~~~~~~~~
   include/acpi/acpi_bus.h:64:21: error: unknown type name 'acpi_handle'
    bool acpi_check_dsm(acpi_handle handle, const u8 *uuid, u64 rev, u64 funcs);
                        ^~~~~~~~~~~
   include/acpi/acpi_bus.h:65:38: error: unknown type name 'acpi_handle'
    union acpi_object *acpi_evaluate_dsm(acpi_handle handle, const u8 *uuid,
                                         ^~~~~~~~~~~
   include/acpi/acpi_bus.h:69:25: error: unknown type name 'acpi_handle'
    acpi_evaluate_dsm_typed(acpi_handle handle, const u8 *uuid, u64 rev, u64 func,
                            ^~~~~~~~~~~
   include/acpi/acpi_bus.h:70:30: error: unknown type name 'acpi_object_type'
       union acpi_object *argv4, acpi_object_type type)
                                 ^~~~~~~~~~~~~~~~
   In file included from drivers/mfd/intel_soc_pmic_chtwc.c:18:0:
   include/acpi/acpi_bus.h:286:40: error: 'ACPI_D_STATE_COUNT' undeclared here (not in a function)
     struct acpi_device_power_state states[ACPI_D_STATE_COUNT]; /* Power states (D0-D3Cold) */
                                           ^~~~~~~~~~~~~~~~~~
   include/acpi/acpi_bus.h:326:2: error: unknown type name 'acpi_handle'
     acpi_handle gpe_device;
     ^~~~~~~~~~~
   include/acpi/acpi_bus.h:356:2: error: unknown type name 'acpi_handle'
     acpi_handle handle;  /* no handle for fixed hardware */
     ^~~~~~~~~~~
   include/acpi/acpi_bus.h:387:2: error: unknown type name 'acpi_handle'
     acpi_handle handle;
     ^~~~~~~~~~~
   include/acpi/acpi_bus.h:478:49: error: expected ')' before 'void'
    void acpi_bus_private_data_handler(acpi_handle, void *);
                                                    ^~~~
   include/acpi/acpi_bus.h:479:44: error: expected ')' before 'void'
    int acpi_bus_get_private_data(acpi_handle, void **);
                                               ^~~~
   include/acpi/acpi_bus.h:480:47: error: expected ')' before 'void'
    int acpi_bus_attach_private_data(acpi_handle, void *);
                                                  ^~~~
   include/acpi/acpi_bus.h:481:1: warning: parameter names (without types) in function declaration
    void acpi_bus_detach_private_data(acpi_handle);
    ^~~~
   include/acpi/acpi_bus.h:490:25: error: unknown type name 'acpi_handle'
    int acpi_bus_get_device(acpi_handle handle, struct acpi_device **device);
                            ^~~~~~~~~~~
   include/acpi/acpi_bus.h:491:46: error: unknown type name 'acpi_handle'
    struct acpi_device *acpi_bus_get_acpi_device(acpi_handle handle);
                                                 ^~~~~~~~~~~
   include/acpi/acpi_bus.h:493:1: error: unknown type name 'acpi_status'
    acpi_status acpi_bus_get_status_handle(acpi_handle handle,
    ^~~~~~~~~~~
   include/acpi/acpi_bus.h:493:40: error: unknown type name 'acpi_handle'
    acpi_status acpi_bus_get_status_handle(acpi_handle handle,
                                           ^~~~~~~~~~~
   include/acpi/acpi_bus.h:497:24: error: unknown type name 'acpi_handle'
    int acpi_bus_set_power(acpi_handle handle, int state);
                           ^~~~~~~~~~~
   include/acpi/acpi_bus.h:503:27: error: unknown type name 'acpi_handle'
    int acpi_bus_update_power(acpi_handle handle, int *state_p);
                              ^~~~~~~~~~~
   include/acpi/acpi_bus.h:505:32: error: unknown type name 'acpi_handle'
    bool acpi_bus_power_manageable(acpi_handle handle);
                                   ^~~~~~~~~~~
   include/acpi/acpi_bus.h:510:40: error: unknown type name 'acpi_handle'
    static inline bool acpi_bus_can_wakeup(acpi_handle handle) { return false; }
                                           ^~~~~~~~~~~
   include/acpi/acpi_bus.h:520:19: error: unknown type name 'acpi_handle'
    int acpi_bus_scan(acpi_handle handle);
                      ^~~~~~~~~~~
   include/acpi/acpi_bus.h:522:1: error: unknown type name 'acpi_status'
    acpi_status acpi_bus_get_ejd(acpi_handle handle, acpi_handle * ejd);
    ^~~~~~~~~~~
   include/acpi/acpi_bus.h:522:30: error: unknown type name 'acpi_handle'
    acpi_status acpi_bus_get_ejd(acpi_handle handle, acpi_handle * ejd);
                                 ^~~~~~~~~~~
   include/acpi/acpi_bus.h:522:50: error: unknown type name 'acpi_handle'
    acpi_status acpi_bus_get_ejd(acpi_handle handle, acpi_handle * ejd);
                                                     ^~~~~~~~~~~
   include/acpi/acpi_bus.h:581:1: warning: parameter names (without types) in function declaration
    int acpi_is_root_bridge(acpi_handle);
    ^~~
   include/acpi/acpi_bus.h:582:42: error: unknown type name 'acpi_handle'
    struct acpi_pci_root *acpi_pci_find_root(acpi_handle handle);
                                             ^~~~~~~~~~~
   include/acpi/acpi_bus.h:594:15: error: unknown type name 'acpi_status'
    static inline acpi_status acpi_add_pm_notifier(struct acpi_device *adev,
                  ^~~~~~~~~~~
   include/acpi/acpi_bus.h: In function 'acpi_add_pm_notifier':
>> include/acpi/acpi_bus.h:598:9: error: 'AE_SUPPORT' undeclared (first use in this function)
     return AE_SUPPORT;
            ^~~~~~~~~~
   include/acpi/acpi_bus.h:598:9: note: each undeclared identifier is reported only once for each function it appears in
   include/acpi/acpi_bus.h: At top level:
   include/acpi/acpi_bus.h:600:15: error: unknown type name 'acpi_status'
    static inline acpi_status acpi_remove_pm_notifier(struct acpi_device *adev)
                  ^~~~~~~~~~~
   include/acpi/acpi_bus.h: In function 'acpi_remove_pm_notifier':
   include/acpi/acpi_bus.h:602:9: error: 'AE_SUPPORT' undeclared (first use in this function)
     return AE_SUPPORT;
            ^~~~~~~~~~
   include/acpi/acpi_bus.h: In function 'acpi_pm_device_sleep_state':
>> include/acpi/acpi_bus.h:607:8: error: 'ACPI_STATE_D0' undeclared (first use in this function)
      *p = ACPI_STATE_D0;
           ^~~~~~~~~~~~~
   include/acpi/acpi_bus.h:609:37: error: 'ACPI_STATE_D3_COLD' undeclared (first use in this function)
     return (m >= ACPI_STATE_D0 && m <= ACPI_STATE_D3_COLD) ?
                                        ^~~~~~~~~~~~~~~~~~
   include/acpi/acpi_bus.h: In function 'acpi_target_system_state':
   include/acpi/acpi_bus.h:630:59: error: 'ACPI_STATE_S0' undeclared (first use in this function)
    static inline u32 acpi_target_system_state(void) { return ACPI_STATE_S0; }
                                                              ^~~~~~~~~~~~~
   include/acpi/acpi_bus.h: In function 'acpi_device_can_poweroff':
   include/acpi/acpi_bus.h:645:28: error: 'ACPI_STATE_D3_COLD' undeclared (first use in this function)
     return adev->power.states[ACPI_STATE_D3_COLD].flags.valid ||
                               ^~~~~~~~~~~~~~~~~~
   include/acpi/acpi_bus.h:646:5: error: 'acpi_gbl_FADT' undeclared (first use in this function)
      ((acpi_gbl_FADT.header.revision < 6) &&
        ^~~~~~~~~~~~~
   include/acpi/acpi_bus.h:647:22: error: 'ACPI_STATE_D3_HOT' undeclared (first use in this function)
      adev->power.states[ACPI_STATE_D3_HOT].flags.explicit_set);
                         ^~~~~~~~~~~~~~~~~
   In file included from drivers/mfd/intel_soc_pmic_chtwc.c:19:0:
   include/linux/acpi.h: In function 'acpi_device_handle':
   include/linux/acpi.h:51:29: warning: pointer/integer type mismatch in conditional expression
     return adev ? adev->handle : NULL;
                                ^
   drivers/mfd/intel_soc_pmic_chtwc.c: In function 'cht_wc_probe':
   drivers/mfd/intel_soc_pmic_chtwc.c:104:11: error: implicit declaration of function 'acpi_evaluate_integer' [-Werror=implicit-function-declaration]
     status = acpi_evaluate_integer(handle, "_HRV", NULL, &hrv);
              ^~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/AE_SUPPORT +598 include/acpi/acpi_bus.h

d760a1baf2 Lorenzo Pieralisi      2016-11-21  576  void acpi_dma_configure(struct device *dev, enum dev_dma_attr attr);
d760a1baf2 Lorenzo Pieralisi      2016-11-21  577  void acpi_dma_deconfigure(struct device *dev);
b84f196d96 Suthikulpanit, Suravee 2015-10-28  578  
d9fef0c4d2 Rafael J. Wysocki      2013-11-28  579  struct acpi_device *acpi_find_child_device(struct acpi_device *parent,
d9fef0c4d2 Rafael J. Wysocki      2013-11-28  580  					   u64 address, bool check_children);
275582031f Alexander Chiang       2009-06-10  581  int acpi_is_root_bridge(acpi_handle);
76d56de57a Alex Chiang            2009-07-23 @582  struct acpi_pci_root *acpi_pci_find_root(acpi_handle handle);
4e10d12a3d David Shaohua Li       2005-03-18  583  
b67ea76172 Rafael J. Wysocki      2010-02-17  584  int acpi_enable_wakeup_device_power(struct acpi_device *dev, int state);
b67ea76172 Rafael J. Wysocki      2010-02-17  585  int acpi_disable_wakeup_device_power(struct acpi_device *dev);
b67ea76172 Rafael J. Wysocki      2010-02-17  586  
aa33860158 Rafael J. Wysocki      2011-02-11  587  #ifdef CONFIG_PM
c072530f39 Rafael J. Wysocki      2014-07-23  588  acpi_status acpi_add_pm_notifier(struct acpi_device *adev, struct device *dev,
c072530f39 Rafael J. Wysocki      2014-07-23  589  				 void (*work_func)(struct work_struct *work));
c072530f39 Rafael J. Wysocki      2014-07-23  590  acpi_status acpi_remove_pm_notifier(struct acpi_device *adev);
ee85f54371 Huang Ying             2012-06-23  591  int acpi_pm_device_sleep_state(struct device *, int *, int);
5de21bb998 Rafael J. Wysocki      2014-11-27  592  int acpi_pm_device_run_wake(struct device *, bool);
761afb869f Rafael J. Wysocki      2010-10-14  593  #else
ec2cd81ccf Rafael J. Wysocki      2012-11-02  594  static inline acpi_status acpi_add_pm_notifier(struct acpi_device *adev,
c072530f39 Rafael J. Wysocki      2014-07-23  595  					       struct device *dev,
c072530f39 Rafael J. Wysocki      2014-07-23  596  				               void (*work_func)(struct work_struct *work))
ec2cd81ccf Rafael J. Wysocki      2012-11-02  597  {
ec2cd81ccf Rafael J. Wysocki      2012-11-02 @598  	return AE_SUPPORT;
ec2cd81ccf Rafael J. Wysocki      2012-11-02  599  }
c072530f39 Rafael J. Wysocki      2014-07-23 @600  static inline acpi_status acpi_remove_pm_notifier(struct acpi_device *adev)
ec2cd81ccf Rafael J. Wysocki      2012-11-02  601  {
ec2cd81ccf Rafael J. Wysocki      2012-11-02  602  	return AE_SUPPORT;
ec2cd81ccf Rafael J. Wysocki      2012-11-02  603  }
b25c77efa7 Rafael J. Wysocki      2013-06-16  604  static inline int acpi_pm_device_sleep_state(struct device *d, int *p, int m)
296699de6b Rafael J. Wysocki      2007-07-29  605  {
296699de6b Rafael J. Wysocki      2007-07-29  606  	if (p)
296699de6b Rafael J. Wysocki      2007-07-29 @607  		*p = ACPI_STATE_D0;
b25c77efa7 Rafael J. Wysocki      2013-06-16  608  
8ad928d52e Rafael J. Wysocki      2013-07-30  609  	return (m >= ACPI_STATE_D0 && m <= ACPI_STATE_D3_COLD) ?
8ad928d52e Rafael J. Wysocki      2013-07-30  610  		m : ACPI_STATE_D0;

:::::: The code at line 598 was first introduced by commit
:::::: ec2cd81ccfc055155ef4ca673f207168f516d287 ACPI / PM: Move routines for adding/removing device wakeup notifiers

:::::: TO: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--azLHFNyN32YCQGCU
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
Gm3XhQEA

--azLHFNyN32YCQGCU
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--azLHFNyN32YCQGCU--
